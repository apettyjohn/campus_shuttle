// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'rideDialogue.dart';

class RideList extends StatelessWidget {
  final List rides;
  const RideList({Key? key, required this.rides}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: rides.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Ride(
              pickup: rides[index]['pickup'],
              dropoff: rides[index]['dropoff'],
              passenger: rides[index]['passengers'],
              index: index,
            ),
          );
        },
      ),
    );
  }
}

class Ride extends StatelessWidget {
  final String pickup;
  final String dropoff;
  final int passenger;
  final int index;

  const Ride({
    Key? key,
    required this.pickup,
    required this.dropoff,
    required this.passenger,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => ViewRide(
                  pickup: pickup,
                  dropoff: dropoff,
                  passenger: passenger,
                  index: index));
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${index + 1} |',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pickup:',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Drop-off:',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pickup,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red.shade900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  dropoff,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red.shade900,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                  height: 20, child: Image.asset('assets/images/person.png')),
            ),
            Text(
              '$passenger',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey[500],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[400],
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
