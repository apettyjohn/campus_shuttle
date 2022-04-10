import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:campus_shuttle/databaseFunctions.dart';

class LoginBox extends StatefulWidget {
  const LoginBox({Key? key}) : super(key: key);

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  bool driverCheckBox = false;
  bool driverError = false;
  bool adminCheckBox = false;
  bool adminError = false;
  bool serverError = false;
  bool loginError = false;
  bool loading = false;
  String name = '', email = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                controller: _nameController,
                onChanged: (String value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                controller: _emailController,
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: loading
                  ? const CircularProgressIndicator()
                  : loginError
                      ? const Text('* Invalid name or email',
                          style: TextStyle(color: Colors.red))
                      : serverError
                          ? const Text(
                              '* Server error, try again later',
                              style: TextStyle(color: Colors.red),
                            )
                          : driverError && driverCheckBox
                              ? const Text(
                                  '* You are not authorized as a driver',
                                  style: TextStyle(color: Colors.red),
                                )
                              : adminError && adminCheckBox
                                  ? const Text(
                                      '* You are not authorized as an admin',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : null,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(20)),
                  onPressed: () async {
                    loading = true;
                    setState(() {});
                    var request = await postRequest(
                        'login', {"name": name, "email": email});
                    if (request.statusCode == 200) {
                      serverError = false;
                      driverError = false;
                      adminError = false;
                      var body = jsonDecode(request.body);
                      loginError = !body['valid'];
                      if (driverCheckBox) {
                        driverError = !body['driver'];
                      }
                      if (adminCheckBox) {
                        adminError = !body['admin'];
                      }
                    } else {
                      serverError = true;
                    }
                    loading = false;
                    if (!loginError && !serverError) {
                      if (!driverError && !adminError) {
                        if (driverCheckBox) {
                          Navigator.pushNamed(context, '/driver');
                        } else if (adminCheckBox) {
                          Navigator.pushNamed(context, '/admin');
                        } else {
                          Navigator.pushNamed(context, '/requestRide');
                        }
                      }
                    }
                    setState(() {});
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
                    value: driverCheckBox,
                    onChanged: (checked) {
                      setState(() {
                        driverCheckBox = checked!;
                        adminCheckBox = false;
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
                    value: adminCheckBox,
                    onChanged: (checked) {
                      setState(() {
                        adminCheckBox = checked!;
                        driverCheckBox = false;
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
