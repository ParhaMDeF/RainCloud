// To parse this JSON data, do
//
//     final nearbyCities = nearbyCitiesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NearbyCities nearbyCitiesFromJson(String str) =>
    NearbyCities.fromJson(json.decode(str));

class NearbyCities {
  NearbyCities({
    required this.cod,
    required this.count,
    required this.list,
  });

  String cod;
  int count;
  List<ListElement> list;

  factory NearbyCities.fromJson(Map<String, dynamic> json) => NearbyCities(
        cod: json["cod"],
        count: json["count"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );
}

class ListElement {
  ListElement({
    required this.id,
    required this.name,
    required this.coord,
    required this.main,
    required this.wind,
    required this.rain,
    required this.snow,
    required this.weather,
  });

  int id;
  String name;
  Coord coord;
  MainClass main;
  Wind wind;
  dynamic rain;
  dynamic snow;
  List<Weather> weather;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        main: MainClass.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        rain: json["rain"],
        snow: json["snow"],
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );
}

class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });

  double lat;
  double lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class MainClass {
  MainClass({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  double speed;
  int deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}
