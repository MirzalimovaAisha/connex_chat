import 'package:connex_chat/screens/bottom_navi.dart';
import 'package:connex_chat/screens/intro_page.dart';
import 'package:connex_chat/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => IntroPage(),
        '/login': (context) => LoginPage(),
        '/bottom_navi': (context) => BottomNavi()
      },
    );
  }
}
