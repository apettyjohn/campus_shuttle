// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:campus_shuttle/widgets/requestRide/waitTimeBox.dart';
import 'package:campus_shuttle/widgets/requestStatus/cancelDialogue.dart';

class RequestStatusPage extends StatefulWidget {
  const RequestStatusPage({Key? key}) : super(key: key);

  @override
  State<RequestStatusPage> createState() => _RequestStatusPageState();
}

class _RequestStatusPageState extends State<RequestStatusPage> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    final bool serverOn = args['person']['server'];
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
            const Text(
              'Campus Shuttle',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
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
                                        style:
                                            TextStyle(color: Colors.red[900])),
                                    const TextSpan(
                                        text:
                                            'after arrival if the rider is not ready to board.'),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ), //REQUEST BUTTON
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                border: Border.all(
                                  color: Colors.green.shade900,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Text(
                                'View Map',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/map',
                                  arguments: args);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ), //REQUEST BUTTON
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.red[100],
                                border: Border.all(
                                  color: Colors.red.shade900,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Text(
                                'Cancel Ride',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      ConfirmCancel(args: args));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: WaitTimeBox(serverOn: serverOn),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
