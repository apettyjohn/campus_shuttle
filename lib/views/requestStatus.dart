import 'package:flutter/material.dart';
import '../widgets/requestStatus/cancelDialogue.dart';

class RequestStatusPage extends StatefulWidget {
  const RequestStatusPage({Key? key}) : super(key: key);

  @override
  State<RequestStatusPage> createState() => _RequestStatusPageState();
}

class _RequestStatusPageState extends State<RequestStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pushNamed(context, '/requestRide'),
        ),
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
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
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
                    width: 500,
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
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 16, fontFamily: 'Lora'),
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
                              Navigator.pushNamed(context, '/map');
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
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
                                      const ConfirmCancel());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
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
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            'Estimated Wait Time:',
                            style: TextStyle(
                              fontSize: 27,
                              color: Colors.blueGrey.shade900,
                            ),
                          ),
                        ),
                        Text(
                          '10 min',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ],
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
