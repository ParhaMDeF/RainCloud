import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/consts.dart';

class HourlyForsCast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HourlyItems(
              temp: 11,
              weatherType: 'icons/15.png',
              hour: '01:00 PM',
              color: purple),
          HourlyItems(
              temp: 10,
              weatherType: 'icons/20.png',
              hour: '03:00 PM',
              color: purple),
          HourlyItems(
              temp: 14,
              weatherType: 'icons/13.png',
              hour: '07:00 AM',
              color: gold),
          HourlyItems(
              temp: 20,
              weatherType: 'icons/17.png',
              hour: '09:00 AM',
              color: gold),
          HourlyItems(
              temp: 25,
              weatherType: 'icons/18.png',
              hour: '11:00 AM',
              color: gold),
        ],
      ),
    );
  }
}

class HourlyItems extends StatelessWidget {
  HourlyItems(
      {required this.temp,
      required this.hour,
      required this.weatherType,
      required this.color});

  int temp;
  String hour, weatherType;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 40),
          width: 20,
          height: 27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 17.0, sigmaY: 17.0),
            child: Container(
              padding: EdgeInsets.all(0),
              width: 100,
              height: 120,
              child: Column(
                children: [
                  Image.asset(
                    weatherType,
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(height: 15),
                  Text(
                    hour,
                    style: TextStyle(
                        color: gray, fontSize: 12, fontFamily: 'Roboto'),
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
            ),
          ),
        ),
      ],
    );
  }
}
