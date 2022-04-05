import 'package:flutter/material.dart';
import 'package:campus_shuttle/widgets/centeredView.dart';
import 'package:campus_shuttle/widgets/login/header.dart';
import 'package:campus_shuttle/widgets/login/body.dart';
import 'package:campus_shuttle/widgets/login/footer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Header(),
            CenteredView(child: LoginBox()),
            Spacer(),
            Footer()
          ]),
    );
  }
}
