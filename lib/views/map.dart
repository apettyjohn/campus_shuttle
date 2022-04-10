import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    var ride = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.red[900],
            height: 75,
            child: ElevatedButton(
              onPressed: () async {
                // Navigate back to first route when tapped.
                Navigator.pushNamed(context, '/requestStatus', arguments: ride);
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Go back to status page',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(30), child: Text('$ride')),
        ],
      ),
    );
  }
}
