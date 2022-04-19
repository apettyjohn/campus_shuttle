// ignore_for_file: file_names

import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:flutter/material.dart';

//CONFIRM CANCEL
class ConfirmCancel extends StatefulWidget {
  final Map args;
  final bool serverOn;
  const ConfirmCancel({Key? key, required this.args, required this.serverOn})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ConfirmCancel> createState() => _ConfirmCancelState(serverOn: serverOn);
}

class _ConfirmCancelState extends State<ConfirmCancel> {
  bool loading = false;
  bool serverOn;

  _ConfirmCancelState({required this.serverOn});

  @override
  Widget build(BuildContext context) {
    final Map body = widget.args;
    final Map ride = body['ride'];
    final Map person = body['person'];

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blueGrey.shade900,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 250,
        width: 500,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Confirm Cancel?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blueGrey.shade900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
              child: ElevatedButton(
                onPressed: () async {
                  loading = true;
                  setState(() {});
                  if (serverOn) {
                    await postRequest(
                        'rides', {"method": "delete", "ride": ride});
                    Navigator.pushNamed(context, '/requestRide',
                        arguments: person);
                  } else {
                    Navigator.pushNamed(context, '/requestRide',
                        arguments: person);
                  }
                  loading = false;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Cancel',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700)),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(width: 4, color: Colors.red.shade500),
                    ),
                    primary: Colors.red.shade100),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: loading ? const CircularProgressIndicator() : null,
            ),
          ],
        ),
      ),
    );
  }
}
