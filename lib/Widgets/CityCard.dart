import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/SaveLocation.dart';

import '../SearchLocationScreen.dart';
import '../consts.dart';

class CityCard extends StatelessWidget {
  CityCard({
    required this.cityName,
    required this.weatherType,
    required this.temp,
    required this.asset,
    required this.lat,
    required this.lon,
  });

  var cityName, weatherType, asset, temp, lat, lon;

  @override
  Widget build(BuildContext context) {
    if (temp != null) {
      temp -= 272;
    } else {
      temp = 0;
    }
    return Positioned(
      bottom: MediaQuery.of(context).size.width * 0.4,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: GlassContainer.clearGlass(
          color: Color(0xFF1e2228).withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
          width: 140,
          height: 140,
          child: MaterialButton(
            onPressed: () async {
              var loc = Provider.of<SaveLocation>(context, listen: false);
              await loc.saveToStorage(cityName, lat.toString(), lon.toString());
              ScaffoldMessenger.of(context).showSnackBar(saveSnackBar);
            },
            splashColor: darkGrey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(cityName,
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  SizedBox(height: 12),
                  Image.asset(asset, width: 50, height: 50),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(temp.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          Text('°',
                              style: TextStyle(
                                  color: gold,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(width: 12),
                      Text(weatherType,
                          style: TextStyle(
                              color: gray,
                              fontSize: 13.5,
                              fontFamily: 'Roboto'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
