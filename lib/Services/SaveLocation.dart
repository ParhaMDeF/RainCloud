import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLocation extends ChangeNotifier {
  SharedPreferences? preferences;

  Future<void> saveToStorage(String cityName, String lat, String lon) async {
    this.preferences = await SharedPreferences.getInstance();
    this.preferences?.setStringList(cityName, [lat, lon]);
  }

  List<String>? getLocation(String cityName) {
    return preferences?.getStringList(cityName);
  }
    @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
