// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:campus_shuttle/widgets/requestRide/locationPicker.dart';
import 'package:campus_shuttle/databaseFunctions.dart';

class RequestRidePage extends StatefulWidget {
  const RequestRidePage({Key? key}) : super(key: key);

  @override
  State<RequestRidePage> createState() => _RequestRidePageState();
}

//HOMEPAGE
class _RequestRidePageState extends State<RequestRidePage> {
  late Future<int> waitTime;

  @override
  void initState() {
    super.initState();
    waitTime = getWaitTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pushNamed(context, '/login'),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.red[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                height: 50,
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
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
              child: Column(
                children: [
                  const LocationPicker(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.blueGrey.shade900,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Estimated Wait Time:',
                            style: TextStyle(fontSize: 30),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder<int>(
                                future: waitTime,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text('${snapshot.data!}',
                                        style: TextStyle(
                                            color: Colors.red[900],
                                            fontSize: 24));
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return const Text('Wait time is empty');
                                  }
                                },
                              ),
                              Text(' min',
                                  style: TextStyle(
                                      color: Colors.red[900], fontSize: 24)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Need special assistance?  '),
                              Text(
                                'Tap Here!',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<int> getWaitTime() async {
  var response = await getRequest('waitTime');
  if (response.statusCode == 200) {
    return int.parse(response.body);
  } else {
    return -1;
  }
}
