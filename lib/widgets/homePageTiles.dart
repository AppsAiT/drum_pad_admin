import 'package:flutter/material.dart';

class HomePageTile extends StatelessWidget {
  HomePageTile({super.key, required this.title, required this.image});

  String title;
  String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13, left: 13, right: 13, bottom: 8),
      child: Container(
        height: 200,
        width: 180,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 75, 75, 75),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 120,
              width: 120,
              child: Image(
                image: AssetImage(image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 27),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}