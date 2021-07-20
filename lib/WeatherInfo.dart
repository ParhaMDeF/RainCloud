import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'consts.dart';

class WeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'icons/world.png',
          width: 450,
          height: 300,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            SizedBox(height: 60),
            Image.asset(
              'icons/12.png',
              width: MediaQuery.of(context).size.width * 0.45,
            ),
            SizedBox(height: 25),
            Text(
              'Thunder',
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'Roboto'),
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '13',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 85,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'),
                ),
                Text(
                  '°',
                  style: TextStyle(
                      color: gold,
                      fontSize: 85,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05)
          ],
        ),
      ],
    );
  }
}
