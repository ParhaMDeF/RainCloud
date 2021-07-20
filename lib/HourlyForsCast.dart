import 'package:flutter/cupertino.dart';
import 'package:weather/consts.dart';

class HourlyForsCast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HourlyItems(temp: 11,weatherType: 'icons/15.png' , hour: '01:00 PM',),
          HourlyItems(temp: 10,weatherType: 'icons/20.png' , hour: '03:00 PM',),
          HourlyItems(temp: 14,weatherType: 'icons/13.png' , hour: '07:00 AM',),
          HourlyItems(temp: 20,weatherType: 'icons/17.png' , hour: '09:00 AM',),
          HourlyItems(temp: 25,weatherType: 'icons/18.png' , hour: '11:00 AM',),
        ],
      ),
    );
  }
}

class HourlyItems extends StatelessWidget {
  HourlyItems(
      {required this.temp, required this.hour, required this.weatherType});

  int temp;
  String hour, weatherType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      width: 100,
      height: 150,
      child: Column(
        children: [
          Image.asset(
            weatherType,
            width: 45,
            height: 45,
          ),
          SizedBox(height: 15),
          Text(
            hour,
            style: TextStyle(color: gray, fontSize: 12, fontFamily: 'Roboto'),
          ),
          SizedBox(height: 15),
          Text(
            '$temp' + '°',
            style: TextStyle(
                color: grey,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
