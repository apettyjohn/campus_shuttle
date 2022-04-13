// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:campus_shuttle/widgets/driver/rideList.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  var rides = [];
  late Timer timer;
  bool serverOn = true;

  Future<void> getRidesWrapper() async {
    rides = await getRides();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (serverOn) {
      getRidesWrapper();
      // ignore: unused_local_variable
      timer = Timer.periodic(
          const Duration(seconds: 5), (Timer t) => getRidesWrapper());
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    serverOn = args['server'];
    if (!serverOn) {
      timer.cancel();
      rides = [
        {"pickup": "Opus Hall", "dropoff": "Maloney Hall", "passengers": 2},
        {"pickup": "Pryzbyla", "dropoff": "Maloney Hall", "passengers": 4},
        {"pickup": "Pryzbyla", "dropoff": "Brookland Metro", "passengers": 7},
        {"pickup": "Opus Hall", "dropoff": "Brookland Metro", "passengers": 5}
      ];
      setState(() {});
    }
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
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                'Rides:',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.blueGrey.shade900,
                ),
              ),
            ),
            rides.isEmpty
                ? const Text('No Rides Requested',
                    style: TextStyle(
                      fontSize: 24,
                    ))
                : rides[0]['passengers'] < 1
                    ? Text('Server Error',
                        style: TextStyle(color: Colors.red[900], fontSize: 24))
                    : RideList(rides: rides, serverOn: serverOn),
          ],
        ),
      ),
    );
  }
}
