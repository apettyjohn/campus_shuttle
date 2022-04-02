import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double textFieldPadding = 10.0;
  bool _submit = false;
  String _firstName = '';
  String _lastName = '';
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  void _toggleSubmit() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: SizedBox.expand(
          child: Card(
            color: Colors.red[700],
            elevation: 10,
            child: Center(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Text(
                          'CUA Campus Shuttle Login',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: textFieldPadding,
                            horizontal: 2 * textFieldPadding),
                        child: TextField(
                          autofocus: true,
                          controller: firstnameController,
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
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: textFieldPadding,
                            horizontal: 2 * textFieldPadding),
                        child: TextField(
                          controller: lastnameController,
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
                      ),
                      Padding(
                        padding: EdgeInsets.all(2 * textFieldPadding),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/map');
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 25)),
                          ),
                          child: const Text(
                            'Submit',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
