// ignore_for_file: file_names

import 'package:campus_shuttle/databaseFunctions.dart';
import 'package:flutter/material.dart';

class WaitTimeBox extends StatefulWidget {
  final bool serverOn;
  final bool allElements;
  final int index;
  final bool? helpText;
  final Function? callback;
  const WaitTimeBox(
      {Key? key,
      required this.serverOn,
      required this.allElements,
      required this.index,
      this.helpText,
      this.callback})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<WaitTimeBox> createState() => _WaitTimeBoxState(
      serverOn: serverOn, allElements: allElements, index: index);
}

class _WaitTimeBoxState extends State<WaitTimeBox> {
  bool serverOn;
  bool allElements;
  int index;
  bool helpText = false;
  Function? callback;
  var waitTime = 0;

  _WaitTimeBoxState(
      {required this.serverOn, required this.allElements, required this.index});

  // update waitTime
  Future<void> waitTimeWrapper() async {
    if (serverOn) {
      if (allElements) {
        if (index < 0) {
          waitTime = await getFullWaitTime();
        } else {
          waitTime = await getTimeToRide(index);
        }
      } else if (index >= 0) {
        waitTime = await getWaitTime(index);
      } else {
        waitTime = await getWaitTime(0);
      }
      if (callback != null) {
        //print('Refreshing parent');
        callback!();
      }
      setState(() {});
    }
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
    if (widget.callback != null) {
      callback = widget.callback!;
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: allElements
                        ? const Text('Estimated Wait Time:',
                            style: TextStyle(fontSize: 28))
                        : const Text('Drive Time:',
                            style: TextStyle(fontSize: 28)),
                  ),
                ),
                allElements
                    ? IconButton(
                        onPressed: () {
                          waitTimeWrapper();
                        },
                        icon: const Icon(Icons.refresh))
                    : Container(),
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
