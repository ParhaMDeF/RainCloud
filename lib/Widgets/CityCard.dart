import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/SaveLocation.dart';
import '../consts.dart';

class CityCard extends StatelessWidget {
  CityCard(
      {required this.cityName,
      required this.weatherType,
      required this.temp,
      required this.asset,
      required this.lat,
      required this.lon,
      required this.network});

  var cityName, weatherType, asset, temp, lat, lon, network;

  @override
  Widget build(BuildContext context) {
    if (temp != null) {
      temp -= 272;
    } else {
      temp = 0;
    }
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GlassContainer.clearGlass(
        color: Color(0xFF1e2228).withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        blur: 2.2,
        width: 160,
        height: 160,
        child: MaterialButton(
          onPressed: () async {
            bool? s =
                context.read<SaveLocation>().savedCity?.contains(cityName);
            if (cityName != 'N/A') {
              if (s == false || s == null) {
                var loc = Provider.of<SaveLocation>(context, listen: false);
                await loc.saveToStorage(
                    cityName, lat.toString(), lon.toString());
                await loc.getLocation();
                await network.getCMHDWeather(lat.toString(), lon.toString());
                ScaffoldMessenger.of(context).showSnackBar(saveSnackBar);
              } else
                ScaffoldMessenger.of(context)
                    .showSnackBar(saveFailedSnackBar);
            }
          },
          splashColor: darkGrey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    cityName,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
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
                    Flexible(
                      child: Text(weatherType,
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: gray,
                              fontSize: 13.5,
                             )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
