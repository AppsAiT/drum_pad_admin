import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drum_pad_admin/widgets/membershipCard.dart';
import 'package:drum_pad_admin/widgets/priceEdit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  var gold, diamond, platinum;
  TextEditingController _goldPriceController = TextEditingController();
  TextEditingController _diamondPriceController = TextEditingController();
  TextEditingController _platinumPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // getdata() async {
  //   await FirebaseFirestore.instance
  //       .collection('membership')
  //       .doc('Gold')
  //       .get()
  //       .then((value) {
  //     gold = value.data();
  //   });
  //   // await FirebaseFirestore.instance
  //   //     .collection('membership')
  //   //     .doc('Diamond')
  //   //     .get()
  //   //     .then((value) {
  //   //   diamond = value.data()!;
  //   // });
  //   // await FirebaseFirestore.instance
  //   //     .collection('membership')
  //   //     .doc('Platinum')
  //   //     .get()
  //   //     .then((value) {
  //   //   platinum = value.data()!;
  //   // });
  // }

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
        title: const Text(
          'Premium Membership',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: 3,
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('membership')
                      .doc('Gold')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.data != null) {
                      gold = snapshot.data;
                      return MembershipCard(
                        title: "GOLD",
                        image: 'Assets/goldPlan.png',
                        price: gold['amount'],
                        color: const Color.fromARGB(255, 255, 243, 139),
                      );
                    } else {
                      const Text('Something went wrong ==== 2');
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('membership')
                      .doc('Diamond')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.data != null) {
                      diamond = snapshot.data;
                      return MembershipCard(
                        title: "DIAMOND",
                        image: 'Assets/diamondPlan.png',
                        price: diamond['amount'],
                        color: const Color.fromARGB(255, 173, 245, 255),
                      );
                    } else {
                      const Text('Something went wrong ==== 2');
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('membership')
                      .doc('Platinum')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.data != null) {
                      platinum = snapshot.data;
                      return MembershipCard(
                        title: "PLATINUM",
                        image: 'Assets/platinumPlan.png',
                        price: platinum['amount'],
                        color: const Color.fromARGB(255, 210, 210, 210),
                      );
                    } else {
                      const Text('Something went wrong ==== 2');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PriceEdit(
                  price: '29.99',
                  type: 'Gold',
                  controller: _goldPriceController,
                ),
                PriceEdit(
                  price: '59.99',
                  type: 'Diamod',
                  controller: _diamondPriceController,
                ),
                PriceEdit(
                  price: '79.99',
                  type: 'Platinum',
                  controller: _platinumPriceController,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
