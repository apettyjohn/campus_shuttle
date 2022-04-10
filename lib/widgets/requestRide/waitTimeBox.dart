// ignore_for_file: file_names

import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:flutter/material.dart';

class WaitTimeBox extends StatefulWidget {
  final bool helpText;
  const WaitTimeBox({Key? key, required this.helpText}) : super(key: key);

  @override
  State<WaitTimeBox> createState() => _WaitTimeBoxState();
}

class _WaitTimeBoxState extends State<WaitTimeBox> {
  bool helpText = false;
  late Future<int> waitTime;

  @override
  void initState() {
    super.initState();
    waitTime = getWaitTime();
  }

  @override
  Widget build(BuildContext context) {
    helpText = widget.helpText;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blueGrey.shade900,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Estimated Wait Time:',
              style: TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: FutureBuilder<int>(
                    future: waitTime,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data! < 0) {
                          return Text('Server Error',
                              style: TextStyle(
                                  color: Colors.red[900], fontSize: 26));
                        }
                        return Text('${snapshot.data!} min',
                            style: TextStyle(
                                color: Colors.red[900], fontSize: 26));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: helpText
                  ? [
                      const Text('Need special assistance?  '),
                      const Text(
                        'Tap Here!',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ]
                  : [],
            ),
          ],
        ),
      ),
    );
  }
}
