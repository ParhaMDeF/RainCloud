import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:weather/consts.dart';

bool show = true;

class SearchLocationScreen extends StatefulWidget {
  @override
  _SearchLocationScreenState createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Text(
          'Search for city',
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: 26, color: Colors.white),
        ),
        SizedBox(height: 20),
        TextFiled(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        Stack(
          alignment: AlignmentDirectional.center,
          overflow: Overflow.visible,
          children: [
            Image.asset(
              'icons/world.png',
              fit: BoxFit.fill,
            ),
            CityCards(),
            MoreCitiesWidget(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            WeatherData(),
          ],
        ),
      ],
    ));
  }
}

class WeatherData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * (-0.14),
      child: GlassContainer.clearGlass(
        color: Color(0xFF1e2228).withOpacity(0.6),
        borderRadius: BorderRadius.circular(25),
        width: 300,
        height: 180,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [Precipation(), SizedBox(height: 40), Humidity()],
              ),
              Column(
                children: [Wind(), SizedBox(height: 40), Presure()],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Presure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Presure',
          style: TextStyle(fontSize: 16.5, color: darkGrey),
        ),
        SizedBox(height: 10),
        Text(
          '840hpa',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}

class Wind extends StatelessWidget {
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
          '8 km/h',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}

class Humidity extends StatelessWidget {
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
          '30%',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}

class Precipation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Precipation',
          style: TextStyle(fontSize: 16.5, color: darkGrey),
        ),
        SizedBox(height: 10),
        Text(
          '30%',
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
              width: 120,
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
                      'More cities',
                      style: TextStyle(fontSize: 11.5, color: gray),
                    ),
                    SizedBox(width: 5),
                    SvgPicture.asset(
                      'icons/Star.svg',
                      color: gray,
                      width: 14,
                      height: 14,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class CityCards extends StatelessWidget {
  const CityCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.width * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CitiesCard(
              temp: 36,
              asset: 'icons/26.png',
              weatherType: 'Sunny',
              cityName: 'Karaj'),
          CitiesCard(
              cityName: 'Tehran',
              temp: 40,
              asset: 'icons/6.png',
              weatherType: 'Wind'),
        ],
      ),
    );
  }
}

class TextFiled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        autofocus: false,
        style: TextStyle(color: grey, fontFamily: 'Roboto', fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () {},
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
  CitiesCard(
      {required this.cityName,
      required this.weatherType,
      required this.temp,
      required this.asset});

  int temp;
  String cityName, weatherType, asset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GlassContainer.clearGlass(
        color: Color(0xFF1e2228).withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        width: 140,
        height: 140,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                cityName,
                style: TextStyle(color: Colors.white, fontSize: 17),
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
    );
  }
}
