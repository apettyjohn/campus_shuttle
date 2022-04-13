import 'package:flutter/material.dart';
import 'views/admin.dart';
import 'views/driverPage.dart';
import 'views/requestRide.dart';
import 'views/login.dart';
import 'views/map.dart';
import 'views/requestStatus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      routes: {
        '/admin': (context) => const AdminPage(),
        '/login': (context) => const LoginPage(),
        '/map': (context) => const MapScreen(),
        '/driver': (context) => const DriverPage(),
        '/requestRide': (context) => const RequestRidePage(),
        '/requestStatus': (context) => const RequestStatusPage(),
      },
      theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Lora')),
      home: const LoginPage(),
    );
  }
}
