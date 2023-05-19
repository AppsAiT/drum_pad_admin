import 'package:drum_pad_admin/widgets/uploadImage.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          children: const [
            Text(
              'ALL SONGS LIST',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            ImageUploadWidget(),
          ],
        ),
      ),
    );
  }
}
