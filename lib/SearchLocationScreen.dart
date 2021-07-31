import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/IconManager.dart';
import 'package:weather/Widgets/GlassyWeatherDataWidget.dart';
import 'package:weather/consts.dart';
import 'package:weather/Services/Networking.dart';
import 'Widgets/CityCard.dart';

import 'Widgets/NearbyCitiesButton.dart';
import 'Widgets/SearchTextFIeld.dart';

class SearchLocationScreen extends StatelessWidget {
  static const String id = 'searchLocationScreen';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var data = Provider.of<Networking>(context);
    var icon = IconManager.codeToIcon;
    return ListView(
      children: [
        SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search for city',
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            SizedBox(height: 20),
            TextFiled(),
            SizedBox(height: height * 0.15),
            Stack(
              alignment: AlignmentDirectional.center,
              overflow: Overflow.visible,
              children: [
                Image.asset('icons/world.png', fit: BoxFit.fill),
                CityCard(
                  cityName: data.weatherData?.name ?? 'N/A',
                  weatherType: data.weatherData?.weather[0].main ?? 'N/A',
                  temp: data.weatherData?.main.temp.toInt() ?? 272,
                  asset: icon[data.weatherData?.weather[0].icon] ??
                      'icons/DClearSky.png',
                  lat: data.weatherData?.coord.lat ?? 0,
                  lon: data.weatherData?.coord.lon ?? 0,
                  network: data,
                ),
                NearbyCitiesButton(data),
                SizedBox(height: height * 0.15),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * (-0.14),
                  child: GlassyWeatherDataWidget(
                    index: 1,
                    humidity: data.weatherData?.main.humidity,
                    pressure: data.weatherData?.main.pressure,
                    wind: data.weatherData?.wind.speed,
                    uv: 0,
                    max: data.weatherData?.main.tempMax.toInt(),
                    min: data.weatherData?.main.tempMin.toInt(),
                  ),
                ),
                data.loading
                    ? Container(
                        width: 75,
                        height: 35,
                        child: LoadingIndicator(
                            indicatorType: Indicator.lineScale,
                            strokeWidth: 1,
                            colors: const [gray]),
                      )
                    : Container()
              ],
            ),
          ],
        )),
      ],
    );
  }
}
