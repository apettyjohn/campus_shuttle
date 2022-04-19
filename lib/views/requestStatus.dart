// ignore_for_file: file_names

import 'dart:convert';

import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:flutter/material.dart';
import 'package:campus_shuttle/widgets/requestRide/waitTimeBox.dart';
import 'package:campus_shuttle/widgets/requestStatus/cancelDialogue.dart';

class RequestStatusPage extends StatefulWidget {
  final bool serverOn;
  const RequestStatusPage({Key? key, required this.serverOn}) : super(key: key);

  @override
  State<RequestStatusPage> createState() =>
      // ignore: no_logic_in_create_state
      _RequestStatusPageState(serverOn: serverOn);
}

class _RequestStatusPageState extends State<RequestStatusPage> {
  final bool serverOn;
  int queue = -1;
  Map ride = {};
  bool initialized = false;
  _RequestStatusPageState({required this.serverOn});

  Future<void> getQueue(Map ride) async {
    final response = await postRequest('queue', ride).then((value) => value);
    if (response.statusCode == 200) {
      var position = jsonDecode(response.body)['queue'];
      queue = position;
    } else {
      queue = -1;
    }
    if (!initialized) {
      initialized = true;
      setState(() {});
    }
  }

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (ModalRoute.of(context)!.settings.arguments == null) {
      return ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text("Return to login"));
    } else {
      var args = ModalRoute.of(context)!.settings.arguments as Map;
      ride = args['ride'];
      getQueue(ride);
      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: Colors.red[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  height: 50,
                  child: Image.asset('assets/images/cuaLogo.png'),
                ),
              ),
              width > 400
                  ? const Text('Campus Shuttle', style: TextStyle(fontSize: 26))
                  : const Text('Shuttle', style: TextStyle(fontSize: 26)),
            ],
          ),
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          width = constraints.maxWidth;
          double padding = 10;
          width > 500
              ? padding = 50
              : width > 400
                  ? padding = 30
                  : null;
          return Container(
            alignment: Alignment.topCenter,
            child: Container(
              constraints:
                  width > 400 ? const BoxConstraints(maxWidth: 600) : null,
              padding: EdgeInsets.fromLTRB(padding, 25, padding, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blueGrey.shade900,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Success!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Lora',
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      const TextSpan(
                                          text:
                                              'Your ride has been requested, pleased be prepared to enter the shuttle upon arrival. The shuttle will depart '),
                                      TextSpan(
                                          text: ' 2 minutes ',
                                          style: TextStyle(
                                              color: Colors.red[900])),
                                      const TextSpan(
                                          text:
                                              'after arrival if the rider is not ready to board.'),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                          // Map button
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/map',
                                    arguments: args);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('View Map',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade700)),
                                  ],
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    side: BorderSide(
                                        width: 3, color: Colors.green.shade500),
                                  ),
                                  primary: Colors.green.shade100),
                            ),
                          ),
                          // Cancel Button
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        ConfirmCancel(
                                            args: args, serverOn: serverOn));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Cancel Ride',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red.shade700)),
                                  ],
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    side: BorderSide(
                                        width: 4, color: Colors.red.shade500),
                                  ),
                                  primary: Colors.red.shade100),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: WaitTimeBox(
                            serverOn: serverOn,
                            allElements: true,
                            index: queue,
                            callback: callback))
                  ],
                ),
              ),
            ),
          );
        }),
      );
    }
  }
}
