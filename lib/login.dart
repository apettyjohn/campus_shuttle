import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _submit = false;
  String _firstName = '';
  String _lastName = '';
  TextEditingController nameController = TextEditingController();

  void _toggleSubmit() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: SizedBox.expand(
          child: Card(
            color: Colors.red[700],
            elevation: 10,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.5,
              child: Container(
                //decoration: const BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(20))),
                color: Colors.white,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      autofocus: true,
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First name',
                      ),
                      onChanged: (text) {
                        setState(() {
                          _firstName = text;
                        });
                      },
                    ),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last name',
                      ),
                      onChanged: (text) {
                        setState(() {
                          _lastName = text;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Submit',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
