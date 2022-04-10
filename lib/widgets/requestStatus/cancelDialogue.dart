// ignore_for_file: file_names

import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:flutter/material.dart';

//CONFIRM CANCEL
class ConfirmCancel extends StatefulWidget {
  final Map ride;
  const ConfirmCancel({Key? key, required this.ride}) : super(key: key);

  @override
  State<ConfirmCancel> createState() => _ConfirmCancelState();
}

class _ConfirmCancelState extends State<ConfirmCancel> {
  bool loading = false;
  bool requestError = false;

  @override
  Widget build(BuildContext context) {
    final Map body = widget.ride;

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
        height: 200,
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
                var response = await postRequest(
                    'rides', {"method": "delete", "ride": body});
                loading = false;
                if (response.statusCode == 202) {
                  requestError = false;
                  Navigator.pushNamed(context, '/requestRide');
                } else {
                  requestError = true;
                }
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
