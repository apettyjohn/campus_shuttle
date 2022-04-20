// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AdminList extends StatefulWidget {
  final bool serverOn;
  final Map args;
  const AdminList({Key? key, required this.serverOn, required this.args})
      : super(key: key);

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  @override
  Widget build(BuildContext context) {
    final Map args = widget.args;
    final List people = args['admins'];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: people.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        Map person = people[index];
        return Dismissible(
          key: Key('${people[index]}'),
          onDismissed: (direction) {
            setState(() {
              people.removeAt(index);
            });
          },
          background: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.delete, color: Colors.white, size: 40)
                ],
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Admin(
              serverOn: widget.serverOn,
              name: person["name"],
              email: person["email"],
              args: args,
            ),
          ),
        );
      },
    );
  }
}

class Admin extends StatefulWidget {
  final bool serverOn;
  final String name;
  final String email;
  final Map args;

  const Admin(
      {Key? key,
      required this.serverOn,
      required this.name,
      required this.email,
      required this.args})
      : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    //print('$name,$email');
    return ElevatedButton(
      onPressed: () {
        clicked = !clicked;
        setState(() {});
      },
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Name:',
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                  SizedBox(height: 5),
                  Text('Email:',
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red.shade900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.email,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red.shade900,
                  ),
                ),
              ],
            ),
            const Spacer(),
            clicked
                ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      var params = widget.args;
                      int i = params['admins'].indexWhere(((person) =>
                          person["email"] == widget.email &&
                          person['name'] == widget.name));
                      params['admins'].removeAt(i);
                      Navigator.pushNamed(context, '/admin', arguments: params);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey[400],
                      size: 35,
                    ))
                : Container(),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 2, color: Colors.black),
          ),
          primary: Colors.white),
    );
  }
}
