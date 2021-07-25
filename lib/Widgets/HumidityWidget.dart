import 'package:flutter/cupertino.dart';
import '../consts.dart';

class Humidity extends StatelessWidget {
  Humidity({required this.humidity});

  var humidity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Humidity',
          style: TextStyle(fontSize: 16.5, color: darkGrey),
        ),
        SizedBox(height: 10),
        Text(
          humidity != 'N/A' ? '$humidity%' : '$humidity',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}