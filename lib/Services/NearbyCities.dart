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
    required this.name,
    required this.coord,
    required this.weather,
  });

  String name;
  Coord coord;

  List<Weather> weather;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
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


class Weather {
  Weather({
    required this.main,
    required this.description,
    required this.icon,
  });

  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );
}

