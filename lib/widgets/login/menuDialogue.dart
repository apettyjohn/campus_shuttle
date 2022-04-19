// ignore_for_file: file_names

import 'package:flutter/material.dart';

//CONFIRM CANCEL
class LoginMenu extends StatefulWidget {
  const LoginMenu({Key? key}) : super(key: key);

  @override
  State<LoginMenu> createState() => _LoginMenuState();
}

class _LoginMenuState extends State<LoginMenu> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        constraints:
            const BoxConstraints(minWidth: 350, maxWidth: 450, maxHeight: 200),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 30),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Report a problem',
                          style: TextStyle(
                              fontSize: 20,
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
          ],
        ),
      ),
    );
  }
}
