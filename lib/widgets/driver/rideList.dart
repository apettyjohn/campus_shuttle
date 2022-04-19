// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'rideDialogue.dart';

class RideList extends StatelessWidget {
  final Map args;
  final bool serverOn;
  const RideList({Key? key, required this.args, required this.serverOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List rides = args['rides'];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: rides.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Ride(
            serverOn: serverOn,
            pickup: rides[index]['pickup'],
            dropoff: rides[index]['dropoff'],
            passenger: rides[index]['passengers'],
            index: index,
            args: args,
          ),
        );
      },
    );
  }
}

class Ride extends StatelessWidget {
  final String pickup;
  final String dropoff;
  final int passenger;
  final int index;
  final bool serverOn;
  final Map args;

  const Ride({
    Key? key,
    required this.pickup,
    required this.dropoff,
    required this.passenger,
    required this.index,
    required this.serverOn,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return serverOn
                  ? ViewRide(
                      serverOn: serverOn,
                      pickup: pickup,
                      dropoff: dropoff,
                      passenger: passenger,
                      index: index,
                      args: args,
                    )
                  : ViewRide(
                      serverOn: serverOn,
                      pickup: pickup,
                      dropoff: dropoff,
                      passenger: passenger,
                      index: index,
                      args: args,
                    );
            });
      },
      child: SizedBox(
        height: 70,
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${index + 1} |',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              constraints.maxWidth > 350
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
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
                    )
                  : Container(),
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
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[400],
                size: 35,
              ),
            ],
          );
        }),
      ),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 2, color: Colors.black),
          ),
          primary: Colors.white),
    );
  }
}
