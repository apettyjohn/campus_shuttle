import 'package:flutter/material.dart';
import 'views/login.dart';
import 'views/map.dart';
import 'views/driverPage.dart';
import 'views/requestPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/map': (context) => const MapScreen(),
        '/driver': (context) => const DriverPage(),
        '/request': (context) => const RequestSentPage(),
      },
      theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Lora')),
      home: const LoginPage(),
    );
  }
}
