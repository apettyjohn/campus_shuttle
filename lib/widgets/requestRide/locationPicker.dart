// ignore_for_file: file_names

import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:flutter/material.dart';

class LocationPicker extends StatefulWidget {
  final Map args;
  const LocationPicker({Key? key, required this.args}) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  bool loading = false;
  bool requestError = false;
  bool serverError = false;
  String pickupValue = 'Opus Hall';
  String dropoffValue = 'Brookland Metro';
  int passengers = 1;
  List<String> options = [
    'Opus Hall',
    'Pryzbyla',
    'Brookland Metro',
    'Maloney Hall'
  ];
  List numPassengers = [for (var i = 1; i <= 9; i++) i];
  double dropdownWidth = 210;
  Map args = {};

  @override
  Widget build(BuildContext context) {
    args = widget.args;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      var width = constraints.maxWidth;
      width > 400 ? dropdownWidth = 250 : null;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blueGrey.shade900,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 25),
              child: Text(
                'Request A Ride',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
            // Pickup Location dropdown
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Pickup:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey.shade900,
                      ),
                    ),
                  ),
                  Container(
                    width: dropdownWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: pickupValue,
                        underline: Container(),
                        icon: const Icon(Icons.arrow_downward),
                        onChanged: (String? newValue) {
                          setState(() {
                            pickupValue = newValue!;
                          });
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Dropoff Location dropdown
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Dropoff:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey.shade900,
                      ),
                    ),
                  ),
                  Container(
                    width: dropdownWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropoffValue,
                        underline: Container(),
                        icon: const Icon(Icons.arrow_downward),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropoffValue = newValue!;
                          });
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Passengers dropdown
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Passengers:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey.shade900,
                      ),
                    ),
                  ),
                  Container(
                    width: dropdownWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: passengers,
                        underline: Container(),
                        icon: const Icon(Icons.arrow_downward),
                        onChanged: (int? newValue) {
                          setState(() {
                            passengers = newValue!;
                          });
                        },
                        items:
                            numPassengers.map<DropdownMenuItem<int>>((value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Loading Icon when a request is made
            Container(
              child: loading
                  ? const CircularProgressIndicator()
                  : requestError
                      ? const Text(
                          '* Invalid Input',
                          style: TextStyle(color: Colors.red),
                        )
                      : serverError
                          ? const Text(
                              '* Server Error',
                              style: TextStyle(color: Colors.red),
                            )
                          : null,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: TextButton(
                //REQUEST BUTTON
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    border: Border.all(
                      color: Colors.red.shade900,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'Request',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.red.shade900,
                    ),
                  ),
                ),
                onPressed: () async {
                  loading = true;
                  setState(() {});
                  final body = {
                    "pickup": pickupValue,
                    "dropoff": dropoffValue,
                    "passengers": passengers
                  };
                  if (pickupValue != dropoffValue) {
                    requestError = false;
                    var response = await postRequest(
                        'rides', {"method": "add", "ride": body});
                    if (response.statusCode == 202) {
                      serverError = false;
                      Navigator.pushNamed(context, '/requestStatus',
                          arguments: {"person": args, "ride": body});
                    } else {
                      serverError = true;
                    }
                  } else {
                    requestError = true;
                  }
                  loading = false;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
