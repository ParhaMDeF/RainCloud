import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/Services/Networking.dart';
import 'package:weather/Services/SaveLocation.dart';
import 'package:weather/consts.dart';
import 'package:provider/provider.dart';

class DateAndLocation extends StatelessWidget {
  DateTime dateTime = DateTime.now();

  Map<String, String> numToMonth = {
    '1': 'Jan',
    '2': 'Feb',
    '3': 'Mar',
    '4': 'Apr',
    '5': 'May',
    '6': 'Jun',
    '7': 'Jul',
    '8': 'Aug',
    '9': 'Sep',
    '10': 'Oct',
    '11': 'Nov',
    '12': 'Dec'
  };

  @override
  Widget build(BuildContext context) {
    var day = dateTime.day;
    var monthNum = dateTime.month;
    var year = dateTime.year;
    String month = numToMonth[monthNum.toString()].toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$day' + ',  ' + '$month ' + '$year',
            style: TextStyle(color: gray, fontSize: 14)),
        SizedBox(height: 8),
        Row(
          children: [
            SvgPicture.asset('icons/Location.svg',
                color: Colors.white, width: 15, height: 15),
            SizedBox(width: 4),
            Text(
                context.read<SaveLocation>().savedCity?.last ??
                    context.read<Networking>().cityName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}
