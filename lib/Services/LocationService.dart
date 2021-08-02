import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends ChangeNotifier {
  var lat, lon;

  Future getLocation() async {
    var loc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = loc.latitude;
    lon = loc.longitude;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
