import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:o_an_quan/screens/setting_screen.dart';
import 'package:o_an_quan/screens/webview_screen.dart';
import 'package:o_an_quan/widgets/background_widgets.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String temp = '';
  var _hasData = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    getHttp();
    super.initState();
  }

  void getHttp() async {
    var dio = Dio();
    var response = await dio.get('https://pastebin.com/raw/4LBfYGN6');
    setState(() {
      temp = response.data;
      _hasData = temp != '0';
    });
    print(temp);
  }

  @override
  Widget build(BuildContext context) {
    return _hasData
        ? WebViewScreen(url: temp)
        : Scaffold(
            body: Container(
              color: const Color(0xff0D723D),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.all(16),
                          width: double.infinity,
                          child: Image.asset('assets/images/logo.png')),
                      const SizedBox(height: 16),
                      Visibility(
                        visible: _hasData,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.green.shade100),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WebViewScreen(url: temp)),
                                );
                              },
                              child: const Text('Bóng Vip',
                                  style: TextStyle(
                                      fontSize: 30, color: Color(0xff0D723D)))),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Background()),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 16, right: 16),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green.shade100),
                            child: const Text(
                              'Chơi',
                              style: TextStyle(
                                  fontSize: 28, color: Color(0xff0D723D)),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsMenu()),
                          );
                        },
                        child: Container(
                            margin: const EdgeInsets.only(left: 16, right: 16),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green.shade100),
                            child: const Text(
                              'Cài đặt',
                              style: TextStyle(
                                  fontSize: 28, color: Color(0xff0D723D)),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewScreen(
                                    url:
                                        'https://vi.wikipedia.org/wiki/%C3%94_%C4%83n_quan')),
                          );
                        },
                        child: Container(
                            margin: const EdgeInsets.only(left: 16, right: 16),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green.shade100),
                            child: const Text(
                              'Hướng dẫn',
                              style: TextStyle(
                                  fontSize: 28, color: Color(0xff0D723D)),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
