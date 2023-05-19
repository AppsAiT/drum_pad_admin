import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drum_pad_admin/widgets/homePageTiles.dart';
import 'package:drum_pad_admin/widgets/sideBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.currentUser});

  final String title;
  final User? currentUser;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String timeText = '';
  String dateText = '';
  String name = '';

  String formatCurrentLiveTime(DateTime time) {
    return DateFormat('hh:mm:ss a').format(time);
  }

  String formatCurrentLiveDate(DateTime date) {
    return DateFormat('dd MMMM, yyyy').format(date);
  }

  getCurrentLiveTime() {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentLiveDate(timeNow);

    if (mounted) {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  getname() async {
    await FirebaseFirestore.instance
        .collection('admins')
        .doc(widget.currentUser!.uid)
        .get()
        .then(
      (value) {
        name = value['name'];
      },
    );
  }

  @override
  void initState() {
    dateText = formatCurrentLiveDate(DateTime.now());
    timeText = formatCurrentLiveTime(DateTime.now());
    getname();
    Timer.periodic(
        const Duration(seconds: 1), (Timer t) => getCurrentLiveTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
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
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: 3,
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome, $name',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  Text(
                    '$timeText \n$dateText',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomePageTile(title: 'ALL SONGS', image: 'Assets/guitar.png'),
                HomePageTile(title: 'ADD SONGS', image: 'Assets/addSongs.png'),
                // HomePageTile(
                //     title: 'TRENDING SONGS', image: 'Assets/guitar.png'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
