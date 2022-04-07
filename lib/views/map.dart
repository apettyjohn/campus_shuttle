import 'package:flutter/material.dart';
import 'package:campus_shuttle/widgets/map/location.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.red[900],
            height: 75,
            child: ElevatedButton(
              onPressed: () {
                // Navigate back to first route when tapped.
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Go back to Login'),
            ),
          ),
          const MyLocation(),
        ],
      ),
    );
  }
}
