import 'package:flutter/material.dart';

class DriverList extends StatelessWidget {
  final bool serverOn;
  final Map people;
  const DriverList({Key? key, required this.serverOn, required this.people})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: people.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Driver(
            serverOn: serverOn,
            name: people[index]['name'],
            email: people[index]['email'],
          ),
        );
      },
    );
  }
}

class Driver extends StatefulWidget {
  final String name;
  final String email;
  final bool serverOn;
  const Driver(
      {Key? key,
      required this.serverOn,
      required this.name,
      required this.email})
      : super(key: key);

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: null,
        child: Row(
          children: [],
        ));
  }
}
