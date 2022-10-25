import 'package:flutter/material.dart';
import 'package:o_an_quan/screens/menu.dart';

void main() {
  print('run');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('a');
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff0D723D),
        body: SafeArea(
          child: Menu(),
        ),
      ),
    );
  }
}