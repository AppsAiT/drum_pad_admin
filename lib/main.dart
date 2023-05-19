import 'package:drum_pad_admin/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

const List<Color> _kDefaultRainbowColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB533aXNj7XfE8T6mMqnvyCVhHPV85pxMs",
      authDomain: "drumpad-appsait.firebaseapp.com",
      projectId: "drumpad-appsait",
      storageBucket: "drumpad-appsait.appspot.com",
      messagingSenderId: "513880157388",
      appId: "1:513880157388:web:264a75b313df648f516669",
      measurementId: "G-BTTR1LKCEZ",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Drum Pad Machine Admin',
            theme: ThemeData(
              primarySwatch: Colors.cyan,
            ),
            home: const MyHomePage(title: 'Drum Pad Machine Admin'),
          );
        } else {
          return const Center(
            child: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

//=============================================================================
//============================= Responsive Drawer =============================
//=============================================================================
