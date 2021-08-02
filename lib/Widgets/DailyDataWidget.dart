import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/Services/IconManager.dart';
import 'package:weather/consts.dart';

class DailyDataWidget extends StatelessWidget {
  DailyDataWidget({required this.data});

  var temp, time, asset;
  var icon = IconManager.codeToIcon;
  var data;

  @override
  Widget build(BuildContext context) {
    var length = data?.daily.length - 1;
    return Container(
      height: 105,
      width: double.infinity,
      child: ListView.builder(
        itemCount: length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return HourlyDailyItems(
            temp: data!.daily[index + 1].temp.day.toInt(),
            time: data.daily[index + 1].dt,
            asset: icon[data.daily[index + 1].weather[0].icon],
          );
        },
      ),
    );
  }
}

class HourlyDailyItems extends StatelessWidget {
  HourlyDailyItems(
      {required this.temp, required this.time, required this.asset});

  int temp;
  var time, asset;

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    var day = days[dateTime.weekday];
    if (temp != null)
      temp -= 272;
    else
      temp = 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(0),
      width: 100,
      height: 120,
      child: Column(
        children: [
          Image.asset(
            asset,
            width: 40,
            height: 40,
          ),
          SizedBox(height: 15),
          Text(
            '$day',
            style: TextStyle(color: gray, fontSize: 12),
          ),
          SizedBox(height: 15),
          Text(
            '$temp' + '°',
            style: TextStyle(
                color: grey, fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
