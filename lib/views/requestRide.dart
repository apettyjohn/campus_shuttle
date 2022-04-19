// ignore_for_file: file_names
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:campus_shuttle/widgets/requestRide/waitTimeBox.dart';
import 'package:flutter/material.dart';
import 'package:campus_shuttle/widgets/requestRide/locationPicker.dart';
import 'package:campus_shuttle/databaseFunctions.dart';

class RequestRidePage extends StatefulWidget {
  final bool serverOn;
  const RequestRidePage({Key? key, required this.serverOn}) : super(key: key);

  @override
  State<RequestRidePage> createState() =>
      // ignore: no_logic_in_create_state
      _RequestRidePageState(serverOn: serverOn);
}

//HOMEPAGE
class _RequestRidePageState extends State<RequestRidePage> {
  bool driverLoginError = false;
  bool serverError = false;
  final String _timeString = DateFormat('H').format(DateTime.now()).toString();
  bool serverOn;

  _RequestRidePageState({required this.serverOn});

  String _getTextGreeting(String name) {
    int time = int.parse(_timeString);
    String output = "";
    time > 17
        ? output = 'Good Evening, $name'
        : time > 11
            ? output = 'Good Afternoon, $name'
            : output = 'Good Morning, $name';
    return output;
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
      String name = "", email = "";
      if (args['name'].length > 0) {
        name = args['name'];
      }
      if (args['email'].length > 0) {
        email = args['email'];
      }

      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
          ),
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
                padding: EdgeInsets.fromLTRB(padding, 10, padding, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          _getTextGreeting(name),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.blueGrey.shade900,
                          ),
                        ),
                      ),
                      // Main ride request body
                      LocationPicker(args: args, serverOn: serverOn),
                      // Wait time box
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: WaitTimeBox(helpText: true, serverOn: serverOn),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                            'Catholic University Office of Transportation and Parking Services'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '202-552-7275',
                          style: TextStyle(
                            color: Colors.blue[800],
                          ),
                        ),
                      ),
                      driverLoginError
                          ? const Text("* Not authorized as a driver",
                              style: TextStyle(color: Colors.red))
                          : serverError
                              ? const Text("* Server Error",
                                  style: TextStyle(color: Colors.red))
                              : Container(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Driver? '),
                            ElevatedButton(
                              onPressed: () async {
                                if (serverOn) {
                                  driverLoginError = false;
                                  var response = await postRequest('drivers', {
                                    "method": "check",
                                    "name": name,
                                    "email": email
                                  });
                                  if (response.statusCode == 200) {
                                    serverError = false;
                                    if (jsonDecode(response.body)['valid']) {
                                      Navigator.pushNamed(context, '/driver',
                                          arguments: args);
                                    } else {
                                      driverLoginError = true;
                                    }
                                  } else {
                                    serverError = true;
                                  }
                                  setState(() {});
                                } else {
                                  Navigator.pushNamed(context, '/driver',
                                      arguments: args);
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Login',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red.shade700)),
                                  ],
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        width: 3, color: Colors.red.shade500),
                                  ),
                                  primary: Colors.red.shade100),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
