import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        toolbarHeight: 70,
        backgroundColor: Colors.red[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                height: 50,
                child: Image.asset('assets/images/cuaLogo.png'),
              ),
            ),
            const Text(
              'Campus Shuttle',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Navigate back to first route when tapped.
                    Navigator.pushNamed(context, '/requestStatus',
                        arguments: args);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Go back to status page',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(30), child: Text('$args')),
                Image.asset("assets/images/staticMap.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
