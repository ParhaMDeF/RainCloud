import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/consts.dart';

import 'DateAndLocation.dart';
import 'HourlyForsCast.dart';
import 'WeatherInfo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.search, color: Colors.white),
              Icon(Icons.language, color: Colors.white),
              Icon(Icons.person, color: Colors.white)
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [DateAndLocation(), WeatherInfo() , HourlyForsCast()],
          ),
        ),
      ),
    );
  }
}
