import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          alignment: Alignment.center,
          color: Colors.red[900],
          height: 75,
          child: ElevatedButton(
            onPressed: () {
              // Navigate back to first route when tapped.
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Go back to Login',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ]),
    );
  }
}
