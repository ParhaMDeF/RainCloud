import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/Networking.dart';
import 'package:weather/Widgets/GlassyWeatherDataWidget.dart';
import 'Services/SaveLocation.dart';
import 'Widgets/DateAndLocation.dart';
import 'Widgets/DailyDataWidget.dart';
import 'Widgets/NavigationDrawer.dart';
import 'Widgets/WeatherInfo.dart';
import 'Widgets/HourlyDataWidget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'consts.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'mainScreen';

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<SaveLocation>(context);
    var network = Provider.of<Networking>(context);
    var net = network.cmhdWeatherData;
    int? length = data.cities?.list.length;
    if(context.read<Networking>().first == true || context.read<Networking>().first == null) {
      FeatureDiscovery.discoverFeatures(context, <String>['drawer']);
    }
    return Scaffold(
      key: _scaffoldkey,
      endDrawer: NavigationDrawer(data, network),
      backgroundColor: Colors.transparent,
      body: LiquidPullToRefresh(
        color: Colors.transparent,
        springAnimationDurationInMilliseconds: 700,
        animSpeedFactor: 6.0,
        showChildOpacityTransition: false,
        onRefresh: () async {
          await network.getCMHDWeather(data.cities?.list[length! - 1].coord.lat,
              data.cities?.list[length! - 1].coord.lon);
        },
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateAndLocation(),
                DescribedFeatureOverlay(
                  featureId: 'drawer',
                  tapTarget: Icon(
                    Icons.menu_rounded,
                    color: gold,
                  ),
                  targetColor: Colors.white,
                  backgroundColor: gold,
                  contentLocation: ContentLocation.below,
                  title: Text(
                    'Click To See Recent Cities',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  pulseDuration: Duration(seconds: 3),
                  enablePulsingAnimation: true,
                  overflowMode: OverflowMode.extendBackground,
                  description: Text(
                    'this button opens recent cities menu',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  child: IconButton(
                      onPressed: () =>
                          _scaffoldkey.currentState!.openEndDrawer(),
                      icon: Icon(
                        Icons.menu_rounded,
                        color: Colors.white,
                      )),
                )
              ],
            ),
            WeatherInfo(network),
            GlassyWeatherDataWidget(
                index: 2,
                humidity: net?.current.humidity,
                pressure: net?.current.pressure,
                wind: net?.current.windSpeed,
                uv: net?.current.uvi,
                max: 0,
                min: 0),
            SizedBox(height: net?.daily.length != 0 ? 30 : 0),
            net?.daily != null ? HourlyDataWidget(data: net) : Container(),
            SizedBox(height: net?.daily.length != 0 ? 30 : 0),
            net?.daily != null ? DailyDataWidget(data: net) : Container(),
          ],
        ),
      ),
    );
  }
}
