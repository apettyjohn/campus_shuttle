import 'package:flutter/material.dart';

class LoginBox extends StatefulWidget {
  const LoginBox({Key? key}) : super(key: key);

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  bool driver = false;
  bool admin = false;

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
            const TextBox(label: 'Name'),
            const TextBox(label: 'Email'),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(20)),
                onPressed: () {
                  Navigator.pushNamed(context, '/map');
                },
                child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                    child: Text('Submit'))),
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
                    child: Text('Driver'),
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
                    child: Text('Admin'),
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
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: TextField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: label),
      ),
    );
  }
}
