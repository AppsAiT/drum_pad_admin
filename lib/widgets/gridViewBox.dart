import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/editSongPage.dart';

class GridViewBox extends StatefulWidget {
  const GridViewBox({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageurl,
    required this.trending,
    required this.genre,
  });

  final String id;
  final String title;
  final String subtitle;
  final String imageurl;
  final String trending;
  final String genre;

  @override
  State<GridViewBox> createState() => _GridViewBoxState();
}

class _GridViewBoxState extends State<GridViewBox> {
  delete() {
    FirebaseFirestore.instance.collection('songs').doc(widget.id).delete().then(
        (doc) {
      SnackBar snackBar = SnackBar(
        content: Text(
          'song Deleted : ${widget.title}, ${widget.id}',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 32, 212, 38),
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }, onError: (e) {
      SnackBar snackBar = SnackBar(
        content: Text(
          'Error deleting : $e',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 173, 5, 5),
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  edit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSong(
          Imageurl: widget.imageurl,
          Subtitle: widget.subtitle,
          Title: widget.title,
          id: widget.id,
          trending: widget.trending,
          genre: widget.genre,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: edit,
            child: Container(
              height: 230,
              width: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 70, 70, 70),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(widget.imageurl),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      widget.subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 18),
              child: InkWell(
                onTap: delete,
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
