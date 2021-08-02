import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/IconManager.dart';
import 'package:weather/Services/Networking.dart';
import 'package:weather/consts.dart';

class WeatherInfo extends StatelessWidget {
  WeatherInfo(this.data);

  var data;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var iconSelection = IconManager.codeToIcon;
    // var network = Provider.of<Networking>(context);

    int? temp = context.read<Networking>().cmhdWeatherData?.current.temp.toInt() ?? 272;
    String? weatherType =
        context.read<Networking>().cmhdWeatherData?.current.weather[0].main ?? 'N/A';
    String? icon =
        iconSelection[context.read<Networking>().cmhdWeatherData?.current.weather[0].icon] ??
            'icons/12.png';
    return Stack(
      children: [
        Image.asset('icons/world.png',
            width: 450, height: 300, fit: BoxFit.cover),
        context.read<Networking>().loading
            ? Container(
                width: 50,
                height: 20,
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
              style: TextStyle(color: Colors.white, fontSize: 18),
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
                  ),
                ),
                Text(
                  '°',
                  style: TextStyle(
                    color: gold,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
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
