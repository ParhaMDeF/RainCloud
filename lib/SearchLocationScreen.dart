import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/IconManager.dart';
import 'package:weather/consts.dart';
import 'package:weather/Services/FindCity.dart';
import 'Widgets/CityCard.dart';
import 'Widgets/HumidityWidget.dart';
import 'Widgets/MinMaxTempWidget.dart';
import 'Widgets/NearbyCitiesButton.dart';
import 'Widgets/PressureWisget.dart';
import 'Widgets/SearchTextFIeld.dart';
import 'Widgets/WindWidget.dart';

class SearchLocationScreen extends StatefulWidget {
  @override
  _SearchLocationScreenState createState() => _SearchLocationScreenState();
}

final errorSnackBar =
    SnackBar(content: Text('city not found'), duration: Duration(seconds: 1));
final saveSnackBar = SnackBar(
    content: Text('City added successfully'), duration: Duration(seconds: 1));

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Search for city',
                style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 20),
              TextFiled(),
              SizedBox(height: height * 0.15),
              Stack(
                alignment: AlignmentDirectional.center,
                overflow: Overflow.visible,
                children: [
                  Image.asset('icons/world.png', fit: BoxFit.fill),
                  Consumer2<FindCity, IconManager>(
                      builder: (context, dynamic data, icon, _) {
                    return CityCard(
                            cityName: data.weatherData?.name ?? 'N/A',
                            weatherType:
                                data.weatherData?.weather[0]?.main ?? 'N/A',
                            temp: data.weatherData?.main.temp.toInt() ?? 272,
                            asset: icon
                                .codeToIcon[data?.weatherData?.weather[0]!.icon] ?? 'icons/DClearSky.png',
                            lat: data.weatherData?.coord.lat ?? 0,
                            lon: data.weatherData?.coord.lon ?? 0,
                          );
                  }),
                  NearbyCitiesButton(),
                  SizedBox(height: height * 0.15),
                  WeatherData(),
                  Consumer<FindCity>(builder: (context, value, _) {
                    return value.loading
                        ? Container(
                            width: 75,
                            height: 35,
                            child: LoadingIndicator(
                                indicatorType: Indicator.lineScale,
                                strokeWidth: 1,
                                colors: const [gray]),
                          )
                        : Container();
                  })
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class WeatherData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<FindCity>(context).weatherData;
    return Positioned(
      bottom: MediaQuery.of(context).size.height * (-0.14),
      child: GlassContainer.clearGlass(
        color: Color(0xFF1e2228).withOpacity(0.6),
        borderRadius: BorderRadius.circular(25),
        width: 300,
        height: 180,
        child: Padding(
            padding: EdgeInsets.all(12.0),
            child: data != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          MinMaxTemp(
                              min: data.main.tempMin.toInt(),
                              max: data.main.tempMax.toInt()),
                          SizedBox(height: 40),
                          Humidity(humidity: data.main.humidity)
                        ],
                      ),
                      Column(
                        children: [
                          WindWidget(wind: data.wind.speed.toInt()),
                          SizedBox(height: 40),
                          Pressure(
                            pressure: data.main.pressure,
                          )
                        ],
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          MinMaxTemp(min: 'N/A', max: 'N/A'),
                          SizedBox(height: 40),
                          Humidity(humidity: 'N/A')
                        ],
                      ),
                      Column(
                        children: [
                          WindWidget(wind: 'N/A'),
                          SizedBox(height: 40),
                          Pressure(pressure: 'N/A')
                        ],
                      )
                    ],
                  )),
      ),
    );
  }
}
