import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/HomeScreen.dart';
import 'package:weather/MainScreen.dart';
import 'package:weather/NearbyCitiesScreen.dart';
import 'package:weather/SearchLocationScreen.dart';
import 'package:weather/consts.dart';
import 'Services/Networking.dart';
import 'Services/IconManager.dart';
import 'Services/LocationService.dart';
import 'Services/SaveLocation.dart';
import 'Splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => Networking()),
        ChangeNotifierProvider(create: (BuildContext context) => IconManager()),
        ChangeNotifierProvider(
            create: (BuildContext context) => SaveLocation()),
        ChangeNotifierProvider(
            create: (BuildContext context) => LocationService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto', scaffoldBackgroundColor: black),
        home: Splash(context),
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          MainScreen.id: (context) => MainScreen(),
          SearchLocationScreen.id: (context) => SearchLocationScreen(),
          NearByCitiesScreen.id: (context) => NearByCitiesScreen(),
        },
      ),
    );
  }
}
