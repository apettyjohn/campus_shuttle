import 'package:flutter/material.dart';

class LoginBox extends StatefulWidget {
  const LoginBox({Key? key}) : super(key: key);

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  bool driver = false;
  bool admin = false;
  bool loginError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Text("Login", style: TextStyle(fontSize: 30)),
            ),
            const TextBox(label: 'Name'),
            const TextBox(label: 'Email'),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(20)),
                  onPressed: () {
                    if (driver) {
                      Navigator.pushNamed(context, '/driver');
                    } else if (admin) {
                      Navigator.pushNamed(context, '/admin');
                    } else {
                      Navigator.pushNamed(context, '/requestRide');
                    }
                  },
                  child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: driver,
                    onChanged: (checked) {
                      setState(() {
                        driver = checked!;
                        admin = false;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Driver', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Checkbox(
                    value: admin,
                    onChanged: (checked) {
                      setState(() {
                        admin = checked!;
                        driver = false;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Admin', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  final String label;
  const TextBox({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: label),
      ),
    );
  }
}
