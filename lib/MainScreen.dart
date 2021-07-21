import 'package:flutter/cupertino.dart';

import 'DateAndLocation.dart';
import 'HourlyForsCast.dart';
import 'WeatherInfo.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(11.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [DateAndLocation(), WeatherInfo(), HourlyForsCast()],
      ),
    );
  }
}
