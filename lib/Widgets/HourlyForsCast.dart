import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/Services/IconManager.dart';
import 'package:weather/consts.dart';

class HourlyDailyForecast extends StatelessWidget {
  HourlyDailyForecast({ required this.data});

  var temp, time, asset;
  var icon = IconManager.codeToIcon;
  var data;
  @override
  Widget build(BuildContext context) {
    var length2 = data?.daily.length -1 ;
    return Container(
      height: 105,
      child: ListView.builder(
        addSemanticIndexes: true,
        itemCount:  length2 ,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return HourlyDailyItems(
                  temp: data!.daily[index+1].temp.day.toInt(),
                  time: data.daily[index+1].dt,
                  asset:
                      icon[data.daily[index+1].weather[0].icon],
                );
        },
      ),
    );
  }
}

class HourlyDailyItems extends StatelessWidget {
  HourlyDailyItems(
      {
      required this.temp,
      required this.time,
      required this.asset});

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

    Color setColor() {
      if ((temp > 15 || temp == null) && ((dateTime.hour < 20) && (dateTime.hour >= 6)))
        return gold;
      else if (dateTime.hour > 20 || dateTime.hour < 6)
        return purple;
      else
        return purple;
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 40),
          width: 20,
          height: 27,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: setColor(),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: Offset(0, 0),
            )
          ]),
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
            ),
          ),
        ),
      ],
    );
  }
}
