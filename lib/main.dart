import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/consts.dart';
import 'HomeScreen.dart';
import 'Services/FindCity.dart';
import 'Services/IconManager.dart';
import 'Services/LocationService.dart';
import 'Services/SaveLocation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => FindCity()),
        ChangeNotifierProvider(create: (BuildContext context) => IconManager()),
        ChangeNotifierProvider(create: (BuildContext context) => SaveLocation()),
        ChangeNotifierProvider(create: (BuildContext context) => LocationService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto', scaffoldBackgroundColor: black),
        home: HomeScreen(),
      ),
    );
  }
}
