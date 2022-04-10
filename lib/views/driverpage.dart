// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:campus_shuttle/widgets/driver/rideList.dart';

final List rides = [
  ['Opus Hall', 'Pryzbyla', 4],
  ['Pryzbyla', 'Dufour Center', 6],
  ['Gibbons Hall', 'St. Vincent Chapel', 2],
  ['Brookland Metro', 'Opus Hall', 5],
  ['Opus Hall', 'Pryzbyla', 4],
  ['Pryzbyla', 'Dufour Center', 6],
];

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.red[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SizedBox(
                height: 60,
                child: Image.asset('assets/images/cuaLogo.png'),
              ),
            ),
            const Text(
              'Campus Shuttle',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Rides:',
              style: TextStyle(
                fontSize: 32,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ),
          Expanded(
            child: RideList(rides: rides),
          ),
        ],
      ),
    );
  }
}
