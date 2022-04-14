// ignore_for_file: file_names

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:campus_shuttle/widgets/driver/rideList.dart';

class DriverPage extends StatefulWidget {
  final bool serverOn;
  const DriverPage({Key? key, required this.serverOn}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<DriverPage> createState() => _DriverPageState(serverOn: serverOn);
}

class _DriverPageState extends State<DriverPage> {
  var rides = [];
  late Timer timer;
  bool serverOn;

  _DriverPageState({required this.serverOn});

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
    } else {
      rides = [
        {"pickup": "Opus Hall", "dropoff": "Brookland Metro", "passengers": 2},
        {"pickup": 'Pryzbyla', "dropoff": 'Opus Hall', "passengers": 4},
        {"pickup": 'Pryzbyla', "dropoff": 'Maloney Hall', "passengers": 6},
        {
          "pickup": 'Maloney Hall',
          "dropoff": 'Brookland Metro',
          "passengers": 8
        }
      ];
    }
  }

  void cancelTimer() {
    timer.cancel();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    // expecting {"name":String,"email":String,"rides"?:List}
    if (args.keys.contains('rides')) {
      rides = args['rides'];
      setState(() {});
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          timer.cancel();
          Navigator.pushNamed(context, '/requestRide',
              arguments: {"name": args['name'], "email": args['email']});
        }),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    'Rides:',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  const Spacer(),
                  !serverOn
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              List<String> options = [
                                'Opus Hall',
                                'Pryzbyla',
                                'Brookland Metro',
                                'Maloney Hall'
                              ];
                              var rand = Random();
                              String str1 = "", str2 = "";
                              while (str1 == str2) {
                                str1 = options[rand.nextInt(options.length)];
                                str2 = options[rand.nextInt(options.length)];
                              }
                              rides.add({
                                "pickup": str1,
                                "dropoff": str2,
                                "passengers": rand.nextInt(9) + 1
                              });
                              setState(() {});
                            },
                          ),
                        )
                      : Container(),
                ],
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
                    : RideList(args: {
                        "name": args['name'],
                        "email": args['email'],
                        "rides": rides,
                        "timerFunc": cancelTimer
                      }, serverOn: serverOn),
          ],
        ),
      ),
    );
  }
}
