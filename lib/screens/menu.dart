import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:o_an_quan/screens/webview_screen.dart';

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
    // TODO: implement initState
    getHttp();
    if(temp != '0') {
      _hasData = true;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(temp == '0') {

    }
  }

  void getHttp() async {
    try {
      print('1');
      var dio = Dio();
      print('2');
      var response = await dio.get('https://pastebin.com/raw/4LBfYGN6');
      print('3');
      print(response.data.toString());
      setState(() {
        temp = response.data;
      });
      print(temp);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _hasData? WebViewScreen(url: temp,):Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(temp == '0')TextButton(onPressed: () {}, child: const Text('Bắt đầu')),
              TextButton(
                  onPressed: () {
                    getHttp();
                  },
                  child: const Text('Hướng dẫn')),

              TextButton(onPressed: () {}, child: const Text('Giới thiệu')),
            ],
          ),
        ),
      ),
    );
  }
}
