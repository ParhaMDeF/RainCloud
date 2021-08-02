import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/Services/IconManager.dart';
import 'package:weather/consts.dart';

class HourlyDataWidget extends StatelessWidget {
  HourlyDataWidget({required this.data});

  var temp, time, asset;
  var icon = IconManager.codeToIcon;
  var data;

  @override
  Widget build(BuildContext context) {
    var length = data?.hourly.length - 1;
    return Container(
      height: 105,
      width: double.infinity,
      child: ListView.builder(
        itemCount: length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return HourlyDailyItems(
            temp: data!.hourly[index + 1].temp.toInt(),
            time: data.hourly[index + 1].dt,
            asset: icon[data.hourly[index + 1].weather[0].icon],
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
    if (temp != null)
      temp -= 272;
    else
      temp = 0;

    Color setColor() {
      if ((temp > 15) && ((dateTime.hour < 20) && (dateTime.hour >= 6)))
        return gold;
      else if (dateTime.hour > 20 || dateTime.hour < 6)
        return purple;
      else
        return purple;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(0),
      width: 100,
      height: 120,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: setColor().withOpacity(0.2),
          spreadRadius: -20,
          blurRadius: 150,
          offset: Offset(0, -10),
        )
      ]),
      child: Column(
        children: [
          Image.asset(
            asset,
            width: 40,
            height: 40,
          ),
          SizedBox(height: 15),
          Text(
            '${dateTime.hour}:${dateTime.minute}',
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
