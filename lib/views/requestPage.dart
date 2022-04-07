//REQUEST SENT PAGE
import 'package:flutter/material.dart';

import 'driverpage.dart';

class RequestSentPage extends StatefulWidget {
  const RequestSentPage({Key? key}) : super(key: key);

  @override
  State<RequestSentPage> createState() => _RequestSentPageState();
}

class _RequestSentPageState extends State<RequestSentPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: Colors.red[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blueGrey.shade900,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 240,
                  width: 500,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        child: Text(
                          'Success!',
                          style: TextStyle(
                            fontFamily: 'Times',
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.green[800],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            Text(
                              'Your ride has been requested, please be prepared to \nenter the shuttle upon arrival. The shuttle will depart',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Times',
                                fontSize: 16,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '2 minutes ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Times',
                                    fontSize: 16,
                                    color: Colors.red.shade800,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  'after arrival if rider is not ready to board.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Times',
                                    fontSize: 16,
                                    color: Colors.blueGrey.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                          ), //REQUEST BUTTON
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              border: Border.all(
                                color: Colors.red.shade900,
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'Cancel Ride',
                              style: TextStyle(
                                fontFamily: 'Times',
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                const ConfirmCancel());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blueGrey.shade900,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 115,
                  width: 500,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 5),
                        child: Text(
                          'Current Estimated Wait Time:',
                          style: TextStyle(
                            fontFamily: 'Times',
                            fontSize: 27,
                            color: Colors.blueGrey.shade900,
                          ),
                        ),
                      ),
                      Text(
                        estWaitTime.toString() + ' min',
                        style: TextStyle(
                          fontFamily: 'Times',
                          fontSize: 40,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//CONFIRM CANCEL
class ConfirmCancel extends StatefulWidget {
  const ConfirmCancel({Key? key}) : super(key: key);

  @override
  State<ConfirmCancel> createState() => _ConfirmCancelState();
}

class _ConfirmCancelState extends State<ConfirmCancel> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blueGrey.shade900,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 155,
        width: 500,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Confirm Cancel?',
                style: TextStyle(
                  fontFamily: 'Times',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blueGrey.shade900,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  border: Border.all(
                    color: Colors.red.shade900,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Times',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName("/requestPage")

                );
              },
            ),
          ],
        ),
      ),
    );
  }
}