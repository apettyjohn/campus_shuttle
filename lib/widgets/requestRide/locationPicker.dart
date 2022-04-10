// ignore_for_file: file_names

import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:flutter/material.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  bool loading = false;
  bool requestError = false;
  String pickupValue = 'Opus Hall';
  String dropoffValue = 'Pryzbyla';
  int passengers = 1;
  List<String> options = [
    'Opus Hall',
    'Pryzbyla',
    'Brookland Metro',
    'Maloney Hall'
  ];
  List numPassengers = [for (var i = 1; i <= 9; i++) i];

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Text(
                    'Pickup Location:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.grey.shade300,
                    ),
                    child: DropdownButton<String>(
                      value: pickupValue,
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(Icons.arrow_downward),
                      ),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          pickupValue = newValue!;
                        });
                      },
                      items:
                          options.map<DropdownMenuItem<String>>((String value) {
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Drop-off Location:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.grey.shade300,
                    ),
                    child: DropdownButton<String>(
                      value: dropoffValue,
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(Icons.arrow_downward),
                      ),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropoffValue = newValue!;
                        });
                      },
                      items:
                          options.map<DropdownMenuItem<String>>((String value) {
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Passengers:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.grey.shade300,
                    ),
                    child: DropdownButton<int>(
                      value: passengers,
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 140.0),
                        child: Icon(
                          Icons.arrow_downward,
                        ),
                      ),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (int? newValue) {
                        setState(() {
                          passengers = newValue!;
                        });
                      },
                      items: numPassengers.map<DropdownMenuItem<int>>((value) {
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
          Container(
            child: loading
                ? const CircularProgressIndicator()
                : requestError
                    ? const Text(
                        'Error',
                        style: TextStyle(color: Colors.red),
                      )
                    : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
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
                var response =
                    await postRequest('rides', {"method": "add", "ride": body});
                loading = false;
                if (response.statusCode == 202) {
                  requestError = false;
                  Navigator.pushNamed(context, '/requestStatus',
                      arguments: body);
                } else {
                  requestError = true;
                }
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
