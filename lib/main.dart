import 'package:flutter/material.dart';
import 'views/admin.dart';
import 'views/driverPage.dart';
import 'views/requestRide.dart';
import 'views/login.dart';
import 'views/mapScreen.dart';
import 'views/requestStatus.dart';

const bool serverOn = false;

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
      debugShowCheckedModeBanner: false,
      routes: {
        '/admin': (context) => const AdminPage(serverOn: serverOn),
        '/login': (context) => const LoginPage(serverOn: serverOn),
        '/map': (context) => const MapScreen(),
        '/driver': (context) => const DriverPage(serverOn: serverOn),
        '/requestRide': (context) => const RequestRidePage(serverOn: serverOn),
        '/requestStatus': (context) =>
            const RequestStatusPage(serverOn: serverOn),
      },
      theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: Theme.of(context)
              .textTheme
              .apply(fontFamily: 'Lora', bodyColor: Colors.black)),
      home: const LoginPage(serverOn: serverOn),
    );
  }
}
