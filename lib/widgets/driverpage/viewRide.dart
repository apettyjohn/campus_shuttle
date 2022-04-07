import 'package:flutter/material.dart';

// Global Variable Wait-time
int estWaitTime = 10;

class ViewRide extends StatefulWidget {
  final String pickup;
  final String dropoff;
  final int passenger;
  final int index;

  const ViewRide({
    Key? key,
    required this.pickup,
    required this.dropoff,
    required this.passenger,
    required this.index,
  }) : super(key: key);

  @override
  State<ViewRide> createState() => _ViewRideState();
}

class _ViewRideState extends State<ViewRide> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blueGrey.shade900,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        width: 500,
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BackButton(),
                  const Spacer(),
                  Text(
                    'RIDE ' + (widget.index + 1).toString() + ':',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.red.shade900,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Pickup:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey.shade900,
                            ),
                          ),
                          Text(
                            'Drop-off:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.pickup,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red.shade900,
                            ),
                          ),
                          Text(
                            widget.dropoff,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 28,
                          child: Image.asset('assets/images/person.png')),
                      Text(
                        widget.passenger.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 70),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Estimated Wait Time:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    Text(
                      estWaitTime.toString() + ' min',
                      style: TextStyle(
                        fontSize: 30,
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
    );
  }
}
