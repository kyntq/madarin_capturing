import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
              image: DecorationImage(image: NetworkImage('')),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(onPressed: (){}, child: const Text('Bắt đầu')),
              TextButton(onPressed: (){}, child: const Text('Hướng dẫn')),
              TextButton(onPressed: (){}, child: const Text('Giới thiệu')),
            ],
          ),
        ),
      ),
    );
  }
}
