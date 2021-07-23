import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'DateAndLocation.dart';
import 'HourlyForsCast.dart';
import 'Services/LocationService.dart';
import 'WeatherInfo.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<LocationService>(context, listen: false).getLocation();
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
