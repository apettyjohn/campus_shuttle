import 'package:flutter/material.dart';
import 'package:campus_shuttle/widgets/requestRide/locationPicker.dart';

class RequestRidePage extends StatefulWidget {
  const RequestRidePage({Key? key}) : super(key: key);

  @override
  State<RequestRidePage> createState() => _RequestRidePageState();
}

//HOMEPAGE
class _RequestRidePageState extends State<RequestRidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
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
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: LocationPicker()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
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
                        padding: const EdgeInsets.only(top: 16, bottom: 5),
                        child: Text(
                          'Current Estimated Wait Time:',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Need special assistance?',
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Tap Here!',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue[800],
                              ),
                            ),
                          ],
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
