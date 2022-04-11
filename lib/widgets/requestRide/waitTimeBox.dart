// ignore_for_file: file_names

import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:flutter/material.dart';

class WaitTimeBox extends StatefulWidget {
  final bool? helpText;
  final bool? allElements;
  final int? index;
  const WaitTimeBox({Key? key, this.helpText, this.allElements, this.index})
      : super(key: key);

  @override
  State<WaitTimeBox> createState() => _WaitTimeBoxState();
}

class _WaitTimeBoxState extends State<WaitTimeBox> {
  bool helpText = false;
  bool allElements = true;
  int index = -1;
  var waitTime = 0;

  Future<void> waitTimeWrapper() async {
    if (allElements) {
      waitTime = await getFullWaitTime();
    } else if (index >= 0) {
      waitTime = await getWaitTime(index);
    } else {
      waitTime = await getWaitTime(0);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitTimeWrapper();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.helpText != null) {
      helpText = widget.helpText!;
    }
    if (widget.index != null) {
      index = widget.index!;
    }
    if (widget.allElements != null) {
      allElements = widget.allElements!;
    }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Estimated Wait Time:',
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                      onPressed: () async {
                        await waitTimeWrapper();
                      },
                      icon: const Icon(Icons.refresh)),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(5),
                child: waitTime < 0
                    ? Text('Server Error',
                        style: TextStyle(color: Colors.red[900], fontSize: 26))
                    : Text('$waitTime min',
                        style:
                            TextStyle(color: Colors.red[900], fontSize: 26))),
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
