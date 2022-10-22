import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/setting_switch.dart';


class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  var settingSound = false;
  late TextEditingController toc_do_dai;

  late TextEditingController point;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        shape: const Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Setting',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(

                        height: 53,
                        child:

                        TextField(
                          onChanged: (val) {
                            setState(() {

                            });
                          },
                          maxLines: 1,

                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'Point of Mandarin',
                            hintTextDirection: TextDirection.ltr,
                          ),
                        )),
                    SizedBox(

                        height: 53,
                        child: TextField(
                          maxLines: 1,

                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'Tốc độ dải',
                            hintTextDirection: TextDirection.ltr,
                          ),
                        )

                    ),

                    Container(
                      // decoration:
                      //     BoxDecoration(border: Border.all(color: Colors.grey)),
                      height: 56,
                      child: MeetingOption(
                        text: 'Sound',
                        isMute: settingSound,
                        onChange: toggleSound,
                      ),
                    ),


                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void toggleSound(bool temp) {
    setState(() {
      settingSound = temp;
    });
  }


}
