import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/setting_switch.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  var settingSound = false;
  TextEditingController toc_do_dai = TextEditingController();
  TextEditingController point = TextEditingController();
  var pointdp;
  var speedp;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Point of Mandarin'),
                    Container(
                        height: 53,
                        child: TextField(
                          controller: point,
                          onChanged: (val) {
                            setState(() {
                              pointdp = val;
                            });
                          },
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: '(Default 10)',
                            hintTextDirection: TextDirection.ltr,
                          ),
                        )),
                    Text('Speed'),
                    SizedBox(
                        height: 53,
                        child: TextField(
                          controller: toc_do_dai,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'Tốc độ dải',
                            hintTextDirection: TextDirection.ltr,
                          ),
                        )),
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
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('SAVED'),
                      ),
                    )
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
