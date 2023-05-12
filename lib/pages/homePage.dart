import 'package:drum_pad_admin/pages/addSong.dart';
import 'package:drum_pad_admin/pages/allSongsPage.dart';
import 'package:drum_pad_admin/pages/trendingSongsPage.dart';
import 'package:drum_pad_admin/widgets/homePageButtons.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddSong(),
                    ),
                  );
                },
                child: HomePageButtons(title: 'Add Song'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllSongsPage(),
                    ),
                  );
                },
                child: HomePageButtons(title: 'All Songs List'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrendingSongsPage(),
                    ),
                  );
                },
                child: HomePageButtons(title: 'Trending List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
