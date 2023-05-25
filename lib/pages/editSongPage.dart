// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditSong extends StatefulWidget {
  const EditSong({
    super.key,
    required this.id,
    required this.Title,
    required this.Subtitle,
    required this.Imageurl,
  });

  final String Title;
  final String Subtitle;
  final String Imageurl;
  final String id;

  @override
  State<EditSong> createState() => _EditSongState();
}

class _EditSongState extends State<EditSong> {
  late final TextEditingController _songTitleController,
      _songSubTitleController;

  @override
  void initState() {
    super.initState();
    _songTitleController = TextEditingController();
    _songSubTitleController = TextEditingController();
  }

  updateData() {
    if (_songTitleController.text != '' && _songSubTitleController.text != '') {
      FirebaseFirestore.instance.collection('songs').doc(widget.id).update({
        'title': _songTitleController.text,
        'subtitle': _songSubTitleController.text,
      }).then((value) {
        SnackBar snackBar = SnackBar(
          content: Text(
            'song Updated : ${_songTitleController.text}',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 32, 212, 38),
          duration: const Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }).catchError(
        (error) {
          SnackBar snackBar = SnackBar(
            content: Text(
              'Error deleting : $error',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 173, 5, 5),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      );
    } else if (_songTitleController.text != '' &&
        _songSubTitleController.text == '') {
      FirebaseFirestore.instance.collection('songs').doc(widget.id).update({
        'title': _songTitleController.text,
      }).then((value) {
        SnackBar snackBar = SnackBar(
          content: Text(
            'song Updated : ${_songTitleController.text}',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 32, 212, 38),
          duration: const Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }).catchError(
        (error) {
          SnackBar snackBar = SnackBar(
            content: Text(
              'Error deleting : $error',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 173, 5, 5),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      );
    } else if (_songTitleController.text == '' &&
        _songSubTitleController.text != '') {
      FirebaseFirestore.instance.collection('songs').doc(widget.id).update({
        'subtitle': _songSubTitleController.text,
      }).then((value) {
        SnackBar snackBar = SnackBar(
          content: Text(
            'song Updated : ${widget.Title}',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 32, 212, 38),
          duration: const Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }).catchError(
        (error) {
          SnackBar snackBar = SnackBar(
            content: Text(
              'Error deleting : $error',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 173, 5, 5),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      );
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text(
          'Nothing Updated...',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 224, 224, 13),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.cyan,
                Colors.cyanAccent,
                Colors.yellow,
              ],
            ),
          ),
        ),
        title: Text(
          'Edit Song => Song Id : ${widget.id}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: 3,
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.cyanAccent,
                  ),
                  child: Image.network(
                    widget.Imageurl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Title : ${widget.Title}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 40),
                        Text(
                          'Sub Title : ${widget.Subtitle}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Column(
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
                            onTap: () {},
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
                          child: InkWell(
                            onTap: () {},
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
                      ),
                    ],
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
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
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
                        updateData();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: const Text(
                          'Update',
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
      ),
    );
  }
}
