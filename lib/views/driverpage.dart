import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:campus_shuttle/widgets/driverpage/ridelist.dart';

int estWaitTime = 10;

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
        toolbarHeight: 70,
        backgroundColor: Colors.red[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 11),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                height: 50,
                child: Image.asset('lib/icons/cua.png'),
              ),
            ),
            const Text(
              'Campus Shuttle',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Times',
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Rides:',
              style: TextStyle(
                fontFamily: 'Times',
                fontSize: 32,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rides.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Ride(
                  pickup: rides[index][0],
                  dropoff: rides[index][1],
                  passenger: rides[index][2],
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
