import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/Networking.dart';
import 'package:weather/Widgets/GlassyWeatherDataWidget.dart';
import 'Services/SaveLocation.dart';
import 'Widgets/DateAndLocation.dart';
import 'Widgets/HourlyForsCast.dart';
import 'Widgets/WeatherInfo.dart';
import 'Widgets/DailyData.dart';
class MainScreen extends StatelessWidget {

  static const String id = 'mainScreen';

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<SaveLocation>(context);
    var network = Provider.of<Networking>(context);
    var net = network.cmhdWeatherData;
    String? cityName;
    int? length = data.cities?.list.length;
    if (data.cities?.list[length! - 1].name == null) {
      cityName = network.cityName ;
    } else {
      cityName = data.cities?.list[length! - 1].name ?? 'N/A';
    }

    return Padding(
      padding: EdgeInsets.all(11.0),
      child: ListView(
        children: [
          DateAndLocation(cityName: cityName),
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
          net?.daily.length != 0 ? HourlyDailyForecast( data: net) : Container(),
          SizedBox(height: net?.daily.length != 0 ? 30 : 0),
          net?.daily.length != 0 ? Daily(data: net) : Container(),
        ],
      ),
    );
  }
}
