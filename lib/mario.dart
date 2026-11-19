import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        width: 50,
        height: 50,
        'assets/images/stadingMario.png',
      ),
    );
  }
}
