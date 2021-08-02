import 'package:flutter/cupertino.dart';
import 'package:glass_kit/glass_kit.dart';
import 'HumidityWidget.dart';
import 'MinMaxTempWidget.dart';
import 'PressureWisget.dart';
import 'UvWidget.dart';
import 'WindWidget.dart';

class GlassyWeatherDataWidget extends StatelessWidget {
  GlassyWeatherDataWidget({
    required this.index,
    required this.min,
    required this.max,
    required this.humidity,
    required this.wind,
    required this.pressure,
    required this.uv,
  });

  int index;
  var min, max, humidity, wind, pressure, uv;

  @override
  Widget build(BuildContext context) {
    return GlassContainer.clearGlass(
      color: Color(0xFF1e2228).withOpacity(0.6),
      borderRadius: BorderRadius.circular(25),
      width: 300,
      height: 180,
      blur: 2.2,
      child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  index == 1
                      ? MinMaxTemp(
                          min: min != null ? min : 'N/A',
                          max: max != null ? max : 'N/A')
                      : UvWidget(uv: uv),
                  SizedBox(height: 40),
                  Humidity(humidity: humidity != null ? humidity : 'N/A')
                ],
              ),
              Column(
                children: [
                  WindWidget(wind: wind != null ? wind : 'N/A'),
                  SizedBox(height: 40),
                  Pressure(
                    pressure: pressure != null ? pressure : 'N/A',
                  )
                ],
              )
            ],
          )),
    );
  }
}
