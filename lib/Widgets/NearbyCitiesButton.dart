import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../NearbyCitiesScreen.dart';
import '../consts.dart';

class NearbyCitiesButton extends StatelessWidget {
  NearbyCitiesButton(this.cityData);

  var cityData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: MediaQuery.of(context).size.width * 0.25,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                  color: Colors.black45.withOpacity(0.2),
                  border: Border.all(color: darkGrey),
                  borderRadius: BorderRadius.circular(25)),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                onPressed: () async {
                  String lat = cityData.weatherData!.coord.lat.toString();
                  String lon = cityData.weatherData!.coord.lon.toString();
                  await cityData.getNearCities(lat, lon);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NearByCitiesScreen(data: cityData)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nearby cities',
                      style: TextStyle(fontSize: 11.5, color: gray),
                    ),
                    SizedBox(width: 5),
                    SvgPicture.asset('icons/Star.svg',
                        color: gray, width: 14, height: 14)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
