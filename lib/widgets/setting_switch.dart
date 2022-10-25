import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchOption extends StatelessWidget {
  final String text;
  bool isTurnOn;
  final Function(bool) onChange;
  SwitchOption({
    Key? key,
    required this.text,
    required this.isTurnOn,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          CupertinoSwitch(value: isTurnOn, onChanged: onChange)
          // Switch.adaptive(
          //   value: isMute,
          //   onChanged: onChange,
          // ),
        ],
      ),
    );
  }
}