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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        // getHttp();
                        // if (!_hasData) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Background()),
                          );
                        // }
                      },
                      child: const Text('Chơi game',
                        style: TextStyle(fontSize: 32),
                      )
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WebViewScreen(url: 'https://google.com')),
                        );
                      },
                      child: const Text('Hướng dẫn')),
                  TextButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsMenu()),
                    );
                  }, child: const Text('Cài đặt')),
                ],
              ),
            ),
          );
  }
}
