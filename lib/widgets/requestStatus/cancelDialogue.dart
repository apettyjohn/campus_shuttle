import 'package:flutter/material.dart';

//CONFIRM CANCEL
class ConfirmCancel extends StatefulWidget {
  const ConfirmCancel({Key? key}) : super(key: key);

  @override
  State<ConfirmCancel> createState() => _ConfirmCancelState();
}

class _ConfirmCancelState extends State<ConfirmCancel> {
  @override
  Widget build(BuildContext context) {
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
        height: 155,
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
              onPressed: () {
                Navigator.pushNamed(context, '/requestRide');
              },
            ),
          ],
        ),
      ),
    );
  }
}
