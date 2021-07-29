import 'package:flutter/cupertino.dart';
import 'package:weather/Services/CMHDWeatherData.dart';
import 'package:weather/Services/NearbyCities.dart';
import 'package:weather/Services/WeatherData.dart';
import 'package:http/http.dart' as http;

class Networking extends ChangeNotifier {
  var mainUrl = 'https://api.openweathermap.org/data/2.5/';
  WeatherData? weatherData;
  NearbyCities? nearbyCities;
  CMHDWeatherData? cmhdWeatherData;
  var apiKey = '76425cfe00f4740e72d65cf9bba53e1f';
  bool loading = false;
  late int resCode;

  Future getSearchedWeather(String cityName) async {
    loading = true;
    notifyListeners();
    var url = Uri.parse(
        '$mainUrl' + 'weather?q=' + '$cityName' + '&appid=' + '$apiKey');
    print(url);
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        resCode = 200;
        notifyListeners();
        weatherData = weatherDataFromJson(response.body);
        loading = false;
        notifyListeners();
      } else {
        loading = false;
        resCode = 404;
        notifyListeners();
      }
    } catch (e) {
      loading = false;
      resCode = 404;
      notifyListeners();
      print(e);
    }
  }

  Future getNearCities(String lat, String lon) async {
    loading = true;
    notifyListeners();
    var url =
        Uri.parse('$mainUrl' + 'find?lat=$lat&lon=$lon&cnt=50&appid=$apiKey');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        nearbyCities = nearbyCitiesFromJson(response.body);
        notifyListeners();
        loading = false;
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print(e);
    }
  }

  Future getCMHDWeather(var lat, var lon) async {
    loading = true;
    var url = Uri.parse('$mainUrl' +
        'onecall?' +
        'lat=$lat&lon=$lon&exclude=minutely&appid=$apiKey');
    try {
      if (lat != null) {
        http.Response response = await http.get(url);
        if (response.statusCode == 200) {
          cmhdWeatherData = chdWeatherDataFromJson(response.body);
          print(1);
          notifyListeners();
          loading = false;
          notifyListeners();
        } else {
          loading = false;
          notifyListeners();
        }
      } else {
        loading = false;
        notifyListeners();
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print(e);
    }
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
