import 'package:flutter/material.dart';
import 'rideDialogue.dart';

class RideList extends StatefulWidget {
  final List rides;

  const RideList({Key? key, required this.rides}) : super(key: key);

  @override
  State<RideList> createState() => _RideListState();
}

class _RideListState extends State<RideList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.rides.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Ride(
          pickup: widget.rides[index][0],
          dropoff: widget.rides[index][1],
          passenger: widget.rides[index][2],
          index: index,
        );
      },
    );
  }
}

class Ride extends StatefulWidget {
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
  State<Ride> createState() => _RideState();
}

class _RideState extends State<Ride> {
  final int waitTime = estWaitTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7, left: 8, right: 8),
      child: TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => ViewRide(
                  pickup: widget.pickup,
                  dropoff: widget.dropoff,
                  passenger: widget.passenger,
                  index: widget.index));
        },
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade500,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 65,
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      (widget.index + 1).toString(),
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12),
                    child: VerticalDivider(
                      color: Colors.grey[400],
                      thickness: 2,
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
                      SizedBox(height: 5),
                      Text(
                        'Drop-off:',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                      SizedBox(height: 2),
                    ],
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.pickup,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red.shade900,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.dropoff,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red.shade900,
                        ),
                      ),
                      SizedBox(height: 2),
                    ],
                  ),
                ],
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
      ),
    );
  }
}
