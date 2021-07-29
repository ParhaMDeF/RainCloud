import 'dart:convert';

CMHDWeatherData chdWeatherDataFromJson(String str) =>
    CMHDWeatherData.fromJson(json.decode(str));

String cHdToJson(CMHDWeatherData data) => json.encode(data.toJson());

class CMHDWeatherData {
  CMHDWeatherData({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  Current current;
  List<Current> hourly;
  List<Daily> daily;

  factory CMHDWeatherData.fromJson(Map<String, dynamic> json) => CMHDWeatherData(
        current: Current.fromJson(json["current"]),
        hourly:
            List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current": current.toJson(),
        "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
      };
}

class Current {
  Current({
    required this.dt,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });

  int dt;
  double temp;
  int pressure;
  int humidity;
  double windSpeed;
  List<Weather> weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        temp: json["temp"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        windSpeed: json["wind_speed"].toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "temp": temp,
        "pressure": pressure,
        "humidity": humidity,
        "wind_speed": windSpeed,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class Weather {
  Weather({
    required this.main,
    required this.icon,
  });

  String main;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: json["main"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "main": main,
        "icon": icon,
      };
}

class Daily {
  Daily({
    required this.dt,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });

  int dt;
  Temp temp;
  int pressure;
  int humidity;
  double windSpeed;
  List<Weather> weather;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        temp: Temp.fromJson(json["temp"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        windSpeed: json["wind_speed"].toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "pressure": pressure,
        "humidity": humidity,
        "wind_speed": windSpeed,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
  });

  double day;
  double min;
  double max;
  double night;


  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"].toDouble(),
        min: json["min"].toDouble(),
        max: json["max"].toDouble(),
        night: json["night"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
      };
}


