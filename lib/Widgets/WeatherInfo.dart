import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/IconManager.dart';
import 'package:weather/Services/Networking.dart';
import 'package:weather/consts.dart';

class WeatherInfo extends StatefulWidget {
  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {

  @override

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var data = Provider.of<Networking>(context);
    var selectIcon = Provider.of<IconManager>(context).codeToIcon;

    int? temp = data.cmhdWeatherData?.current.temp.toInt() ?? 272;
    String? weatherType = data.cmhdWeatherData?.current.weather[0].main ?? 'N/A';
    String? icon = selectIcon[data.cmhdWeatherData?.current.weather[0].icon] ?? 'icons/12.png';
    return Stack(
      children: [
        Image.asset('icons/world.png',
            width: 450, height: 300, fit: BoxFit.cover),
        data.loading
            ? Container(
                width: 75,
                height: 35,
                child: LoadingIndicator(
                    indicatorType: Indicator.lineScale,
                    strokeWidth: 1,
                    colors: const [gray]),
              )
            : Container(),
        Column(
          children: [
            SizedBox(height: 60),
            Image.asset(icon, width: width * 0.45),
            SizedBox(height: 25),
            Text(
              '$weatherType',
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'Roboto'),
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (temp - 272).toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 65,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'),
                ),
                Text(
                  '°',
                  style: TextStyle(
                      color: gold,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
            SizedBox(height: height * 0.05),
          ],
        ),
      ],
    );
  }
}
