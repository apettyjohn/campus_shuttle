import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:campus_shuttle/databaseFunctions.dart';

// Global vars because the subclass
bool driverCheckBox = false;
bool adminCheckBox = false;

class LoginBox extends StatefulWidget {
  final bool serverOn;
  const LoginBox({Key? key, required this.serverOn}) : super(key: key);

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  late bool serverOn;
  bool driverError = false;
  bool adminError = false;
  bool serverError = false;
  bool loginError = false;
  bool loading = false;
  String name = '', email = '', password = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    serverOn = widget.serverOn;
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
                padding: driverCheckBox || adminCheckBox
                    ? const EdgeInsets.symmetric(vertical: 10)
                    : EdgeInsets.zero,
                child: driverCheckBox || adminCheckBox
                    ? TextField(
                        controller: _passwordController,
                        onChanged: (String value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password"),
                      )
                    : Container()),
            Padding(
              padding: loading ||
                      loginError ||
                      serverError ||
                      driverError ||
                      adminError
                  ? const EdgeInsets.symmetric(vertical: 10)
                  : EdgeInsets.zero,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(width: 4, color: Colors.red.shade500),
                      ),
                      primary: Colors.red.shade100),
                  onPressed: () async {
                    if (serverOn) {
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
                      setState(() {});
                      if (!loginError && !serverError) {
                        if (!driverError && !adminError) {
                          if (driverCheckBox) {
                            Navigator.pushNamed(context, '/driver',
                                arguments: {"name": name, "email": email});
                          } else if (adminCheckBox) {
                            Navigator.pushNamed(context, '/admin',
                                arguments: {"name": name, "email": email});
                          } else {
                            Navigator.pushNamed(context, '/requestRide',
                                arguments: {"name": name, "email": email});
                          }
                        }
                      }
                    } else {
                      loading = false;
                      if (driverCheckBox) {
                        Navigator.pushNamed(context, '/driver',
                            arguments: {"name": name, "email": email});
                      } else if (adminCheckBox) {
                        Navigator.pushNamed(context, '/admin',
                            arguments: {"name": name, "email": email});
                      } else {
                        Navigator.pushNamed(context, '/requestRide',
                            arguments: {"name": name, "email": email});
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Submit',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700)),
                      ],
                    ),
                  )),
            ),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              double width = constraints.maxWidth;
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: width > 250
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CheckboxWText(role: "Driver", setstate: callback),
                          width > 400
                              ? const SizedBox(width: 50)
                              : const SizedBox(width: 10),
                          CheckboxWText(role: "Admin", setstate: callback)
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CheckboxWText(role: "Driver", setstate: callback),
                          CheckboxWText(role: "Admin", setstate: callback)
                        ],
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// Check box class
class CheckboxWText extends StatefulWidget {
  final String role;
  final Function setstate;
  const CheckboxWText({Key? key, required this.role, required this.setstate})
      : super(key: key);

  @override
  State<CheckboxWText> createState() => _CheckboxWTextState();
}

class _CheckboxWTextState extends State<CheckboxWText> {
  @override
  Widget build(BuildContext context) {
    Function rebuild = widget.setstate;
    String text = widget.role;
    String role = text.toLowerCase();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: role == "driver" ? driverCheckBox : adminCheckBox,
          onChanged: (checked) {
            driverCheckBox = false;
            adminCheckBox = false;
            role == "driver"
                ? driverCheckBox = checked!
                : adminCheckBox = checked!;
            rebuild();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Text(text, style: const TextStyle(fontSize: 18)),
        )
      ],
    );
  }
}
