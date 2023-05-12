import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:http/http.dart' as http;

class AddSong extends StatefulWidget {
  const AddSong({super.key});

  @override
  State<AddSong> createState() => _AddSongState();
}

class _AddSongState extends State<AddSong> {
  @override
  Widget build(BuildContext context) {
    String selectedFile = '';
    Uint8List? selectedImageInBytes;
    String imageUrl = '';
    TextEditingController _songTitleController = TextEditingController();
    TextEditingController _songSubTitleController = TextEditingController();
    bool isItemSaved = false;

    @override
    void initState() {
      //deleteVegetable();
      super.initState();
    }

    @override
    void dispose() {
      _songTitleController.dispose();
      _songSubTitleController.dispose();
      super.dispose();
    }

    _selectFile(bool imageFrom) async {
      FilePickerResult? fileResult =
          await FilePicker.platform.pickFiles(allowMultiple: false);

      if (fileResult != null) {
        selectedFile = fileResult.files.first.name;
        setState(() {
          selectedImageInBytes = fileResult.files.first.bytes;
        });
      }
      print(selectedFile);
    }

    Future<String> _uploadFile() async {
      String imageUrl = '';
      try {
        firabase_storage.UploadTask uploadTask;
        firabase_storage.Reference ref = firabase_storage
            .FirebaseStorage.instance
            .ref()
            .child('demosongs')
            .child('/$selectedFile');

        final metadata =
            firabase_storage.SettableMetadata(contentType: 'demoimage/');

        //uploadTask = ref.putFile(File(file.path));
        uploadTask = ref.putData(selectedImageInBytes!, metadata);

        await uploadTask.whenComplete(() => null);
        imageUrl = await ref.getDownloadURL();
      } catch (e) {
        print('----------------------------------------');
        print(e);
      }
      return imageUrl;
    }

    saveItem() async {
      setState(() {
        isItemSaved = true;
      });
      String imgURL = await _uploadFile();
      print('Image Url : $imgURL');

      await FirebaseFirestore.instance.collection('demoSongs').add(
        {
          'title': _songTitleController.text,
          'subtitle': _songSubTitleController.text,
          'img': imgURL,
          'song': '',
          'createdOn': DateTime.now().toIso8601String(),
        },
      ).then((value) {
        setState(() {
          isItemSaved = false;
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const AddSong())));
      });
    }

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
                    child: TextField(
                      controller: _songTitleController,
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
                    child: TextField(
                      controller: _songSubTitleController,
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
                        onTap: () async {
                          await _selectFile(false);
                          // FilePickerResult? file = await FilePicker.platform
                          //     .pickFiles(allowMultiple: false);
                          // if (file != null) {
                          //   selectedFile = file.files.first.name;
                          //   selectedImageInBytes = file.files.first.bytes;
                          // }
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
                          child: selectedFile.isEmpty
                              ? Image.asset(
                                  'Assets/defaultImage.jpg',
                                  fit: BoxFit.cover,
                                )
                              : Image.memory(selectedImageInBytes!),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    saveItem();
                  },
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
}
