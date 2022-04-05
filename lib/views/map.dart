import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Card(
          child: ElevatedButton(
            onPressed: () {
              // Navigate back to first route when tapped.
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Go back to Login'),
          ),
        ),
      ),
    );
  }
}
