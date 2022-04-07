import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<Data> fetchData() async {
  final response = await http.get(Uri.parse('http://localhost:8000/test'));

  if (response.statusCode == 200) {
    return Data.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class Data {
  final String name;
  Data(this.name);

  Data.fromJson(Map<String, dynamic> json) : name = json['name'];
}

void main() => runApp(const MapScreen());

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<Data> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(children: [
              FutureBuilder<Data>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.name);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
