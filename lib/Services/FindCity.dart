import 'package:flutter/cupertino.dart';
import 'package:weather/Services/WeatherData.dart';
import 'package:http/http.dart' as http;

class FindCity extends ChangeNotifier {
  var mainUrl = 'https://api.openweathermap.org/data/2.5/weather?q=';
  WeatherData? weatherData;

  var apiKey = '76425cfe00f4740e72d65cf9bba53e1f';
  bool loading = false;

  Future getResponse(String cityName) async {
    loading = true;
    notifyListeners();
    var url = Uri.parse('$mainUrl$cityName&appid=$apiKey');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      weatherData = weatherDataFromJson(response.body);
      print(response.statusCode);
      notifyListeners();
      loading = false;
      notifyListeners();
    } else {
      print(response.statusCode);

      loading = false;
      notifyListeners();
      throw Exception();
    }
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
