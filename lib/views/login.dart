import 'package:campus_shuttle/widgets/login/menuDialogue.dart';
import 'package:flutter/material.dart';
import 'package:campus_shuttle/widgets/centeredView.dart';
import 'package:campus_shuttle/widgets/login/body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => const LoginMenu());
          },
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: const [
            CenteredView(child: LoginBox()),
          ],
        ),
      ),
    );
  }
}
