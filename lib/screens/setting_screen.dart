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
      backgroundColor: const Color(0xff0D723D),
      appBar: AppBar(
        backgroundColor: const Color(0xff0D723D),
        elevation: 1,
        title: const Text(
          'Cài đặt',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 16, right:  16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Số lượng điểm của Mandarin', style: TextStyle(color: Colors.white)),
                    SizedBox(
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
                            hintText: '(Mặc định 10)',
                            hintTextDirection: TextDirection.ltr,
                          ),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text('Tốc độ', style: TextStyle(color: Colors.white)),
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
                    SizedBox(
                      height: 56,
                      child: MeetingOption(
                        text: 'Âm thanh',
                        isMute: settingSound,
                        onChange: toggleSound,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {

                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.green.shade100),
                          child: const Text(
                            'Lưu',
                            style: TextStyle(fontSize: 21, color: Color(0xff0D723D)),
                            textAlign: TextAlign.center,
                          )),
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
