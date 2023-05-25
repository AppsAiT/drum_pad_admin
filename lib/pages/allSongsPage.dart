import 'package:flutter/material.dart';
import '../widgets/gridShow.dart';

class AllSongsPage extends StatefulWidget {
  const AllSongsPage({super.key});

  @override
  State<AllSongsPage> createState() => _AllSongsPageState();
}

class _AllSongsPageState extends State<AllSongsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('ALL SONGS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            Text(
              'ALL SONGS LIST',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            GridDisplay(),
            // const ImageUploadWidget(),
            // Flexible(
            //   child: GridView.builder(
            //     itemCount: 15,
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 6,
            //     ),
            //     itemBuilder: (context, index) {
            //       return GridViewBox();
            //     },
            //   ),
            // ),
            // Container(
            //   height: 230,
            //   width: 230,
            //   color: Colors.cyanAccent,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(12),
            //         child: Container(
            //           height: 150,
            //           width: 150,
            //           color: Colors.deepOrangeAccent,
            //         ),
            //       ),
            //       const Text(
            //         'Song Title',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 20,
            //         ),
            //       ),
            //       const Text(
            //         'Song Sub Title',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 20,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
