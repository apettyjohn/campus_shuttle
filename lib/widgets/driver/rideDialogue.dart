// ignore_for_file: file_names
import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:campus_shuttle/widgets/requestRide/waitTimeBox.dart';
import 'package:flutter/material.dart';

// Global Variable Wait-time
int estWaitTime = 10;

class ViewRide extends StatefulWidget {
  final String pickup;
  final String dropoff;
  final int passenger;
  final int index;
  final bool serverOn;
  final Map args;

  const ViewRide(
      {Key? key,
      required this.pickup,
      required this.dropoff,
      required this.passenger,
      required this.index,
      required this.serverOn,
      required this.args})
      : super(key: key);

  @override
  State<ViewRide> createState() => _ViewRideState();
}

class _ViewRideState extends State<ViewRide> {
  TextStyle redText = TextStyle(fontSize: 18, color: Colors.red.shade900);

  @override
  Widget build(BuildContext context) {
    final String pickup = widget.pickup;
    final String dropoff = widget.dropoff;
    final int passenger = widget.passenger;
    final int index = widget.index;
    final bool serverOn = widget.serverOn;
    final Map args = widget.args;
    List? rides = args['rides'];
    Function cancelTimer = args['timerFunc'];
    final Map ride = {
      "pickup": pickup,
      "dropoff": dropoff,
      "passengers": passenger
    };
    bool loading = false;
    bool requestError = false;

    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(),
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blueGrey.shade900,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 450,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: BackButton(),
                            ),
                            const Spacer(flex: 1),
                            Text(
                              'RIDE ${index + 1}:',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.red.shade900,
                              ),
                            ),
                            const Spacer(flex: 2),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      pickup,
                                      style: redText,
                                    ),
                                    Text(
                                      dropoff,
                                      style: redText,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    SizedBox(
                                        height: 28,
                                        child: Image.asset(
                                            'assets/images/person.png')),
                                    Text(
                                      passenger.toString(),
                                      style: redText,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        WaitTimeBox(
                            helpText: false,
                            serverOn: serverOn,
                            allElements: false,
                            index: index),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.greenAccent[100],
                              border: Border.all(
                                color: Colors.green.shade400,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text('Arrived at Pickup',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.green[700],
                                          )),
                                    ),
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              border: Border.all(
                                color: Colors.red.shade400,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text('Cancel Ride',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.red[700],
                                          )),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  cancelTimer();
                                  loading = true;
                                  setState(() {});
                                  if (serverOn) {
                                    var response = await postRequest('rides',
                                        {"method": "delete", "ride": ride});
                                    if (response.statusCode == 202) {
                                      requestError = false;
                                      Navigator.pushNamed(context, '/driver',
                                          arguments: {
                                            "name": args['name'],
                                            "email": args['email']
                                          });
                                    } else {
                                      requestError = true;
                                    }
                                  } else {
                                    for (var x in rides!) {
                                      if (x['pickup'] == pickup &&
                                          x['dropoff'] == dropoff &&
                                          x['passengers'] == passenger) {
                                        rides.removeAt(rides.indexOf(x));
                                        break;
                                      }
                                    }
                                    Navigator.pushNamed(context, '/driver',
                                        arguments: {
                                          "name": args['name'],
                                          "email": args['email'],
                                          "rides": rides
                                        });
                                  }
                                  loading = false;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: loading
                              ? const CircularProgressIndicator()
                              : requestError
                                  ? const Text(
                                      'Error',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
