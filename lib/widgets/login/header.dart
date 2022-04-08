import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Colors.red[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            child: Image.asset('assets/images/cuaLogo.png'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 25,
              ),
              Text(
                'Campus Shuttle',
                style: TextStyle(fontSize: 40, color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
