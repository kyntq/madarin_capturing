import 'package:flutter/material.dart';
import 'package:o_an_quan/models/board.dart';
import 'package:o_an_quan/screens/menu.dart';
import 'package:o_an_quan/widgets/background_widgets.dart';

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
        body: SafeArea(
          child: Background(),
        ),
      ),
    );
  }
}