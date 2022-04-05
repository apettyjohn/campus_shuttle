import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: Colors.red[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _FooterItem('About'),
          _FooterItem('Contact'),
        ],
      ),
    );
  }
}

class _FooterItem extends StatelessWidget {
  final String title;
  const _FooterItem(this.title);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
