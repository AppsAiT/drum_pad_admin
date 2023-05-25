import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:permission_handler/permission_handler.dart';

class AddSong extends StatefulWidget {
  const AddSong({super.key});

  @override
  State<AddSong> createState() => _AddSongState();
}

class _AddSongState extends State<AddSong> {
  final _formkey = GlobalKey<FormState>();
  late final TextEditingController _songTitleController,
      _songSubTitleController;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  var path, imgUrl;

  @override
  void initState() {
    _songTitleController = TextEditingController();
    _songSubTitleController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _songTitleController.dispose();
      _songSubTitleController.dispose();
    }

    super.dispose();
  }

  // void _uploadForm() async {
  //   final isValid = _formkey.currentState!.validate();
  //   FocusScope.of(context).unfocus();

  //   if (isValid) {
  //     _formkey.currentState!.save();
  //     // if (_pickedImage == null) {
  //     //   print(
  //     //       '------------------------------- Image Empty -------------------------------');
  //     // }
  //     final _uuid = const Uuid().v4();
  //     // try {
  //     //   setState(() {});
  //     fb.StorageReference storageRef =
  //         fb.storage().ref().child('SongImage').child('${_uuid}jpg');
  //     final fb.UploadTaskSnapshot uploadTaskSnapshot =
  //         await storageRef.put(kIsWeb ? webImage : _pickedImage).future;
  //     Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();

  //     print('Title : ${_songTitleController.text}');
  //     print('SubTitle : ${_songSubTitleController.text}');
  //     print('Image : ${imageUri.toString()}');
  //     //   await FirebaseFirestore.instance
  //     //       .collection('DemoSongs')
  //     //       .doc(_uuid)
  //     //       .set({
  //     //     'id': _uuid,
  //     //     'title': _songTitleController.text,
  //     //     'subtitle': _songSubTitleController.text,
  //     // 'image': imageUri.toString(),
  //     //     'createdOn': Timestamp.now(),
  //     //   });
  //     //   _clearForm();
  //     //   Fluttertoast.showToast(
  //     //     msg: 'Song Uploaded Successfully',
  //     //     toastLength: Toast.LENGTH_LONG,
  //     //     gravity: ToastGravity.BOTTOM,
  //     //     timeInSecForIosWeb: 1,
  //     //   );
  //     // } on FirebaseException catch (error) {
  //     //   print('------------ ${error.message}');
  //     //   setState(() {});
  //     // } catch (error) {
  //     //   print('------------ ${error}');
  //     //   setState(() {});
  //     // } finally {
  //     //   setState(() {});
  //     // }
  //   }
  // }

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      path = pickedImageFile!.path;
      _pickedImage = File(pickedImageFile.path);
    });
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile? image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _imagePicker.pickImage(source: ImageSource.gallery))
          as PickedFile?;
      var file = File(image!.path);

      if (image != null) {
        //Upload to Firebase
        var uploadTask =
            _firebaseStorage.ref().child('images/imageName').putFile(file);
        var snapshot = await uploadTask;
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imgUrl = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  void _clearForm() {
    _songSubTitleController.clear();
    _songTitleController.clear();
    setState(() {
      _pickedImage = null;
      webImage = Uint8List(8);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('ADD SONG'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _songTitleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter song title';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 38, 37, 49),
                        border: OutlineInputBorder(),
                        labelText: 'Song Title',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Flexible(
                    child: TextFormField(
                      controller: _songSubTitleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter song sub title';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 38, 37, 49),
                        border: OutlineInputBorder(),
                        labelText: 'Song Sub Title',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: InkWell(
                        onTap: () {
                          _pickImage();
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(255, 38, 37, 49),
                          ),
                          child: const Center(
                              child: Text(
                            'Upload Image',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 38, 37, 49),
                        ),
                        child: const Center(
                            child: Text(
                          'Upload Song',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 38, 37, 49),
                      ),
                      child: Center(
                        child: Container(
                          child: _pickedImage == null
                              ? Image.asset(
                                  'Assets/defaultImage.jpg',
                                  fit: BoxFit.cover,
                                )
                              : kIsWeb
                                  ? Image.network(
                                      path,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.memory(
                                      webImage,
                                      fit: BoxFit.fill,
                                    ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: InkWell(
                      onTap: () {
                        _clearForm();
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: InkWell(
                      onTap: () {
                        print(
                            '====================== NEW SONG BUTTON ======================');
                        // uploadImageToFirebase();
                        uploadImage();
                        print('=========> $imgUrl');
                        // _uploadForm();
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width,/
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // child: Expanded(
        //   child: Column(
        //     children: [
        //       Row(
        //         children: const [
        //           TextField(
        //             decoration: InputDecoration(
        //               border: OutlineInputBorder(),
        //               labelText: 'Song Name',
        //               labelStyle: TextStyle(color: Colors.white),
        //             ),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }

  // Future<void> _pickImage() async {
  //   if (!kIsWeb) {
  //     final ImagePicker _picker = ImagePicker();
  //     XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       var selected = File(image.path);
  //       setState(() {
  //         _pickedImage = selected;
  //       });
  //     } else {
  //       print('No Image has been Picked');
  //     }
  //   } else if (kIsWeb) {
  //     final ImagePicker _picker = ImagePicker();
  //     XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       var f = await image.readAsBytes();
  //       setState(() {
  //         webImage = f;
  //         _pickedImage = File('a');
  //       });
  //     } else {
  //       print('No Image has been picked');
  //     }
  //   } else {
  //     print('Something went wrong');
  //   }
  // }
}
