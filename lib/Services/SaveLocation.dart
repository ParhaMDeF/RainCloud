import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLocation extends ChangeNotifier {
  SharedPreferences? preferences;
  ListElement? listElement;
  SavedCities? cities;

  List<Map<String, dynamic>>? getFromStorage(String savedData) {
    List<Map<String, dynamic>> dOut = [];
    Map<String, dynamic> map = jsonDecode(savedData);
    Map<String, dynamic> myMap;
    var savedCity = SavedCities.fromJson(map);
    int length = savedCity.list.length;
    for (int i = 0; i < length; i++) {
      myMap = {
        "name": savedCity.list[i].name,
        "coord": {
          'lat': savedCity.list[i].coord.lat,
          'lon': savedCity.list[i].coord.lon
        }
      };
      dOut.add(myMap);
    }
    return dOut;
  }

  Future<void> saveToStorage(String cityName, String lat, String lon) async {
    this.preferences = await SharedPreferences.getInstance();
    List<Map<String, dynamic>>? myData = [];
    Map<String, dynamic> data = {};
    String? savedData = preferences!.getString('city');
    print(savedData);
    print('savedData');
    if (savedData != null) {
      myData = getFromStorage(savedData);
      for (int i = 0; i < myData!.length; i++) {
        if (myData[i]["name"] != cityName) {
          if (i == myData.length - 1) {
            myData.add({
              "name": cityName,
              "coord": {'lat': lat, "lon": lon}
            });
          }
          data = {"list": myData};
        } else {
          data = {"list": myData};
        }
      }
    } else {
      data = {
        "list": [
          {
            "name": cityName,
            "coord": {'lat': lat, "lon": lon}
          },
        ]
      };
    }
    preferences?.setString('city', jsonEncode(data));
  }

  Future<void> getLocation() async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    String? savedCities = pre.getString('city');

    if(savedCities != null) {
      cities = savedCitiesFromJson(savedCities);
      print(cities?.list[0].name);
      notifyListeners();
    }
  }
}

SavedCities savedCitiesFromJson(String str) =>
    SavedCities.fromJson(json.decode(str));

String savedCitiesToJson(SavedCities data) => json.encode(data.toJson());

class SavedCities {
  SavedCities({required this.list});

  List<ListElement> list;

  factory SavedCities.fromJson(Map<String, dynamic> json) => SavedCities(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    required this.name,
    required this.coord,
  });

  String name;
  Coord coord;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "coord": coord.toJson(),
      };
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  String lon;
  String lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"],
        lat: json["lat"],
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}
