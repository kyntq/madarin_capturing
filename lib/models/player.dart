import 'package:flutter/material.dart';

class Player {
   String name;
   int score = 0;
  Player(this.name);
}
class Player1  with ChangeNotifier {
  static const String _name = 'Người chơi 1';
  int _score = 0;

  String get name => _name;

  int get score => _score;

  set score(int value) {
    _score = value;
  }
}

class Player2  with ChangeNotifier {
   final String _name = 'Người chơi 2';
  int _score = 0;

  int get score => _score;

  String get name => _name;

  set score(int value) {
    _score = value;
  }
}
