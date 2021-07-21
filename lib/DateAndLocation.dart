import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'consts.dart';

class DateAndLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('22, Feb 2021',
            style: TextStyle(color: gray, fontSize: 14, fontFamily: 'Roboto')),
        SizedBox(height: 8),
        Row(
          children: [
            SvgPicture.asset('icons/Location.svg',
                color: Colors.white, width: 14, height: 18),
            SizedBox(width: 4),
            Text('Tehran, ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto')),
            Text('Iran',
                style:
                    TextStyle(color: gray, fontSize: 15, fontFamily: 'Roboto')),
          ],
        )
      ],
    );
  }
}
