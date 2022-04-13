import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
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
            const Text(
              'Campus Shuttle',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Navigate back to first route when tapped.
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Go back to Login page',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
