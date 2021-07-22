import 'package:flutter/material.dart';
import 'package:weather/consts.dart';
import 'HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto', scaffoldBackgroundColor: black),
      home: HomeScreen(),
    );
  }
}
