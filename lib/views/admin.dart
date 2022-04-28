import 'dart:async';

import 'package:campus_shuttle/widgets/admin/adminList.dart';
import 'package:campus_shuttle/widgets/admin/driverList.dart';
import 'package:flutter/material.dart';

const testList1 = [
  {"name": "Adam Pettyjohn", "email": "pettyjohn@cua.edu"},
  {"name": "Ben Riesett", "email": "riesett@cua.edu"},
  {"name": "Mary Galvin", "email": "galvinma@cua.edu"},
  {"name": "Cheima Aouati", "email": "aouati@cua.edu"}
];
String name1 = "", name2 = "", email1 = "", email2 = "";

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key, required this.serverOn}) : super(key: key);
  final bool serverOn;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final Timer? timer = null; // not implemented
  bool addDriver = false;
  bool addAdmin = false;
  Map args = {
    "name": "name",
    "email": "email",
    "drivers": [...testList1.sublist(0, 2)],
    "admins": [...testList1]
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double padding = 25;
    if (ModalRoute.of(context)!.settings.arguments == null) {
      return ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text("Return to login"));
    } else {
      Map params = ModalRoute.of(context)!.settings.arguments as Map;
      // Expecting {"name":String,"email":email,"drivers":[],"admins":[]}
      if (params['drivers'] != null) {
        args['drivers'] = params['drivers'];
      }
      if (params['admins'] != null) {
        args['admins'] = params['admins'];
      }
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.pushNamed(context, '/login');
          }),
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
              width > 400
                  ? const Text('Campus Shuttle', style: TextStyle(fontSize: 26))
                  : const Text('Shuttle', style: TextStyle(fontSize: 26)),
            ],
          ),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(width: padding),
                          const Text("Drivers", style: TextStyle(fontSize: 30)),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                addDriver = !addDriver;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    addDriver
                        ? AddItemRow(type: 'driver', args: args)
                        : Container(),
                    DriverList(serverOn: widget.serverOn, args: args),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(width: padding),
                          const Text("Administrators",
                              style: TextStyle(fontSize: 30)),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                addAdmin = !addAdmin;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    addAdmin
                        ? AddItemRow(type: "admin", args: args)
                        : Container(),
                    AdminList(serverOn: widget.serverOn, args: args)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}

// Row to add items to list
class AddItemRow extends StatelessWidget {
  final String type;
  final Map args;
  const AddItemRow({Key? key, required this.type, required this.args})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 50, width = 150;
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const Spacer(),
            SizedBox(
              height: height,
              width: width,
              child: TextField(
                controller: controller1,
                onChanged: (String value) {
                  if (type == "driver") {
                    name1 = value;
                  } else {
                    name2 = value;
                  }
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: height,
                width: width,
                child: TextField(
                  controller: controller2,
                  onChanged: (String value) {
                    if (type == "driver") {
                      email1 = value;
                    } else {
                      email2 = value;
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (type == "driver") {
                  args['drivers'].add({"name": name1, "email": email1});
                } else {
                  args['admins'].add({"name": name2, "email": email2});
                }
                name1 = name2 = email1 = email2 = "";
                Navigator.pushNamed(context, '/admin', arguments: args);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('OK',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700)),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 3, color: Colors.red.shade500),
                  ),
                  primary: Colors.red.shade100),
            )
          ],
        ));
  }
}
