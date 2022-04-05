import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.red[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            child: Image.asset('../../../assets/images/cuaLogo.png'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 25,
              ),
              _HeaderItem("Campus Shuttle")
            ],
          )
        ],
      ),
    );
  }
}

class _HeaderItem extends StatelessWidget {
  final String title;
  const _HeaderItem(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 40, color: Colors.white),
    );
  }
}
