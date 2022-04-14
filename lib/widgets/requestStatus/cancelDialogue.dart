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
  bool requestError = false;
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
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  border: Border.all(
                    color: Colors.red.shade900,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              onPressed: () async {
                loading = true;
                setState(() {});
                if (serverOn) {
                  var response = await postRequest(
                      'rides', {"method": "delete", "ride": ride});
                  if (response.statusCode == 202) {
                    requestError = false;
                    Navigator.pushNamed(context, '/requestRide',
                        arguments: person);
                  } else {
                    requestError = true;
                  }
                } else {
                  Navigator.pushNamed(context, '/requestRide',
                      arguments: person);
                }
                loading = false;
                setState(() {});
              },
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
    );
  }
}
