import 'package:flutter/material.dart';
import 'package:campus_shuttle/widgets/login/menuDialogue.dart';
import 'package:campus_shuttle/widgets/login/body.dart';

class LoginPage extends StatelessWidget {
  final bool serverOn;
  const LoginPage({Key? key, required this.serverOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double loginPadding;
    width > 500
        ? loginPadding = 50
        : width > 400
            ? loginPadding = 30
            : loginPadding = 10;

    Widget mainCard = Container(
      padding: EdgeInsets.fromLTRB(loginPadding, 50, loginPadding, 0),
      child: SingleChildScrollView(
        child: LoginBox(serverOn: serverOn),
      ),
    );

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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 400) {
            return Container(
              alignment: Alignment.topCenter,
              child: Container(
                child: mainCard,
                constraints: const BoxConstraints(maxWidth: 700),
              ),
            );
          } else {
            return mainCard;
          }
        },
      ),
    );
  }
}
