import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/IconManager.dart';
import 'package:weather/Services/SaveLocation.dart';
import 'package:weather/consts.dart';
import 'package:weather/Services/FindCity.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => FindCity()),
        ChangeNotifierProvider(create: (BuildContext context) => IconManager()),
        ChangeNotifierProvider(create: (BuildContext context) => SaveLocation())
      ],
      child: Scaffold(
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
                      return data.weatherData == null
                          ? CityCards(
                              cityName: 'N/A',
                              weatherStatus: 'N/A',
                              temp: 272,
                              asset: 'icons/DClearSky.png',
                              lat: 0,
                              lon: 0,
                            )
                          : CityCards(
                              cityName: data.weatherData!.name ?? 'N/A',
                              weatherStatus:
                                  data.weatherData.weather[0]!.main ?? 'N/A',
                              temp:
                                  data.weatherData.main!.temp.toInt() ?? 'N/A',
                              asset: icon.codeToIcon[
                                  data.weatherData.weather[0]!.icon],
                              lat: data.weatherData.coord.lat,
                              lon: data.weatherData.coord.lon,
                            );
                    }),
                    MoreCitiesWidget(),
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
                          Wind(wind: data.wind.speed.toInt()),
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
                          Wind(wind: 'N/A'),
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

class Pressure extends StatelessWidget {
  Pressure({required this.pressure});

  var pressure;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Pressure',
          style: TextStyle(fontSize: 16.5, color: darkGrey),
        ),
        SizedBox(height: 10),
        Text(
          pressure != 'N/A' ? '$pressure hpa' : 'N/A',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}

class Wind extends StatelessWidget {
  Wind({required this.wind});

  var wind;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Wind',
          style: TextStyle(fontSize: 16.5, color: darkGrey),
        ),
        SizedBox(height: 10),
        Text(
          wind != 'N/A' ? '$wind km/h' : 'N/A',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}

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

class MinMaxTemp extends StatelessWidget {
  MinMaxTemp({required this.min, required this.max});

  var min, max;

  @override
  Widget build(BuildContext context) {
    if (min != 'N/A' && max != 'N/A') {
      min -= 272;
      max -= 272;
    }
    return Column(
      children: [
        Text(
          'Min/Max',
          style: TextStyle(fontSize: 16.5, color: darkGrey),
        ),
        SizedBox(height: 10),
        Text(
          min != 'N/A' ? '$min/$max' : 'N/A',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}

class MoreCitiesWidget extends StatelessWidget {
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
                onPressed: () {},
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

class CityCards extends StatelessWidget {
  CityCards({
    required this.cityName,
    required this.weatherStatus,
    required this.temp,
    required this.asset,
    required this.lat,
    required this.lon,
  });

  dynamic cityName, weatherStatus, temp, lat, lon;
  String? asset;

  @override
  Widget build(BuildContext context) {
    if (temp != null) {
      temp -= 272;
    } else {
      temp = 0;
    }
    return Positioned(
      bottom: MediaQuery.of(context).size.width * 0.4,
      child: CitiesCard(
          temp: temp,
          asset: asset,
          weatherType: weatherStatus,
          cityName: cityName,
          lat: lat,
          lon: lon),
    );
  }
}

class TextFiled extends StatefulWidget {
  @override
  State<TextFiled> createState() => _TextFiledState();
}

class _TextFiledState extends State<TextFiled> {
  late String cityName;
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) async {
          _focusNode.unfocus();
          await Provider.of<FindCity>(context, listen: false)
              .getResponse(cityName);
        },
        focusNode: _focusNode,
        autofocus: false,
        onChanged: (input) {
          setState(() {
            cityName = input;
          });
        },
        style: TextStyle(color: grey, fontFamily: 'Roboto', fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () async {
              var city = Provider.of<FindCity>(context, listen: false);
              _focusNode.unfocus();
              await city.getResponse(cityName);
              _focusNode.unfocus();
              if (city.weatherData == null || city.resCode == 404) {
                ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
              }
            },
            icon: SvgPicture.asset(
              'icons/SearchOutline.svg',
              width: 18,
              height: 18,
              color: Colors.white,
            ),
          ),
          filled: true,
          fillColor: Color(0xFF2A2A2A),
          hintText: 'Tehran',
          hintStyle: TextStyle(color: darkGrey),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(25.7)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(25.7)),
        ),
      ),
    );
  }
}

class CitiesCard extends StatelessWidget {
  CitiesCard({
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
    return Padding(
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
            await Future.delayed(Duration(seconds: 5));
            List<String>? s = loc.getLocation(cityName);
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
                        Text(
                          temp.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '°',
                          style: TextStyle(
                              color: gold,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 12),
                    Text(
                      weatherType,
                      style: TextStyle(
                          color: gray, fontSize: 13.5, fontFamily: 'Roboto'),
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
