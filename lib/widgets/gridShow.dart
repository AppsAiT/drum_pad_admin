import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drum_pad_admin/widgets/gridViewBox.dart';
import 'package:flutter/material.dart';

class GridDisplay extends StatefulWidget {
  const GridDisplay({super.key});

  @override
  State<GridDisplay> createState() => _GridDisplayState();
}

class _GridDisplayState extends State<GridDisplay> {
  Widget SongsGrid = StreamBuilder(
    stream: FirebaseFirestore.instance.collection('songs').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error in receiving trip photos: ${snapshot.error}');
      } else {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active) {
          var songsCount = 0;
          List songs;
          if (snapshot.hasData) {
            songs = snapshot.data!.docs;
            songsCount = songs.length;
            if (songsCount > 0) {
              return GridView.builder(
                itemCount: songsCount,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                ),
                itemBuilder: (context, index) {
                  // return Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     color: Colors.amberAccent,
                  //     height: 50,
                  //     width: 50,
                  //     child: Text('index : ${songs[index]['img']}'),
                  //   ),
                  // );
                  return GridViewBox(
                    id: songs[index].id,
                    title: songs[index]['title'],
                    subtitle: songs[index]['subtitle'],
                    imageurl: songs[index]['img'],
                  );
                },
              );
            }
          }
          return Center(
              child: Column(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  "No songs found.",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ));
        }
      }
      return const CircularProgressIndicator();
    },
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(child: SongsGrid);
  }
}
