import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    var network = Provider.of<Networking>(context);
    if (context.read<Networking>().first == true || context.read<Networking>().first == null) {
      FeatureDiscovery.discoverFeatures(
          context, <String>['cityCard', 'nearbyCities']);
      network.first = false;
    }
    var height = MediaQuery.of(context).size.height;
    var icon = IconManager.codeToIcon;
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Search for city',
                style: TextStyle(fontSize: 26, color: Colors.white)),
            SizedBox(height: 20),
            TextFiled(),
            SizedBox(height: height * 0.15),
            Stack(
              alignment: AlignmentDirectional.center,
              overflow: Overflow.visible,
              children: [
                Image.asset('icons/world.png', fit: BoxFit.fill),
                Positioned(
                  bottom: MediaQuery.of(context).size.width * 0.4,
                  child: DescribedFeatureOverlay(
                    featureId: 'cityCard',
                    tapTarget: SvgPicture.asset('icons/Add.svg',
                        color: gold, width: 22, height: 22),
                    targetColor: Colors.white,
                    textColor: gold,
                    backgroundColor: gold,
                    contentLocation: ContentLocation.trivial,
                    title: Text('Click To Add City',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    pulseDuration: Duration(seconds: 3),
                    enablePulsingAnimation: true,
                    barrierDismissible: false,
                    overflowMode: OverflowMode.extendBackground,
                    child: CityCard(
                      cityName: network.weatherData?.name ?? 'N/A',
                      weatherType:
                          network.weatherData?.weather[0].main ?? 'N/A',
                      temp: network.weatherData?.main.temp.toInt() ?? 272,
                      asset: icon[network.weatherData?.weather[0].icon] ??
                          'icons/DClearSky.png',
                      lat: network.weatherData?.coord.lat ?? 0,
                      lon: network.weatherData?.coord.lon ?? 0,
                      network: network,
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.width * 0.25,
                  child: DescribedFeatureOverlay(
                      barrierDismissible: false,
                      featureId: 'nearbyCities',
                      tapTarget: SvgPicture.asset('icons/Star.svg',
                          color: gold, width: 22, height: 22),
                      targetColor: Colors.white,
                      textColor: gold,
                      backgroundColor: gold,
                      contentLocation: ContentLocation.trivial,
                      title: Text('Click To See Nearby Cities',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      pulseDuration: Duration(seconds: 3),
                      enablePulsingAnimation: true,
                      overflowMode: OverflowMode.extendBackground,
                      child: NearbyCitiesButton(network)),
                ),
                // SizedBox(height: height * 0.15),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * (-0.15),
                  child: GlassyWeatherDataWidget(
                    index: 1,
                    humidity: network.weatherData?.main.humidity,
                    pressure: network.weatherData?.main.pressure,
                    wind: network.weatherData?.wind.speed,
                    uv: 0,
                    max: network.weatherData?.main.tempMax.toInt(),
                    min: network.weatherData?.main.tempMin.toInt(),
                  ),
                ),
                context.read<Networking>().loading
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
