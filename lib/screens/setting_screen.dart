import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/setting_switch.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  var settingSound = false;
  TextEditingController speed = TextEditingController();
  TextEditingController point = TextEditingController();
  int? pointdp;
  int? speedp;

  _getConfig() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if(prefs.getInt('point') == null) {
        point.text = '10';
        speed.text = '1';
        settingSound = true;
      } else {
        point.text = '${prefs.getInt('point')}';
        speed.text = '${prefs.getInt('speed')}';
        settingSound = prefs.getBool('sound')!;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getConfig();
    super.initState();
  }

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
          padding: const EdgeInsets.only(top: 20.0, left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Số lượng điểm của quan',
                        style: TextStyle(color: Colors.white)),
                    SizedBox(
                        height: 53,
                        child: TextField(
                          controller: point,
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
                          controller: speed,
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
                      child: SwitchOption(
                        text: 'Âm thanh',
                        isTurnOn: settingSound,
                        onChange: toggleSound,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          final prefs = await SharedPreferences.getInstance();

                          await prefs.setInt('point',  int.parse(point.text));
                          await prefs.setInt('speed', int.parse(speed.text));
                          await prefs.setBool('sound', settingSound);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Đã lưu"),
                          ));
                        } catch (e) {}
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.green.shade100),
                          child: const Text(
                            'Lưu',
                            style: TextStyle(
                                fontSize: 21, color: Color(0xff0D723D)),
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
