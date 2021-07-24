import 'package:flutter/cupertino.dart';
import 'package:weather/Services/NearbyCities.dart';
import 'package:weather/Services/SaveLocation.dart';
import 'package:weather/Services/WeatherData.dart';
import 'package:http/http.dart' as http;

class FindCity extends ChangeNotifier {
  var mainUrl = 'https://api.openweathermap.org/data/2.5/';
  WeatherData? weatherData;
  NearbyCities? nearbyCities;
  var apiKey = '76425cfe00f4740e72d65cf9bba53e1f';
  bool loading = false;
  late int resCode;

  Future getResponse(String cityName) async {
    loading = true;
    notifyListeners();
    var url = Uri.parse('$mainUrl' + 'weather?q=' + '$cityName&appid=$apiKey');
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

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
