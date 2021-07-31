import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/HomeScreen.dart';
import 'package:weather/Services/LocationService.dart';
import 'package:weather/Services/Networking.dart';
import 'package:weather/Services/SaveLocation.dart';

class Splash extends StatefulWidget {
  Splash(this.context);

  BuildContext context;

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late bool firstRun;

  Future<void> setFirstRun() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('firstRun') == null) {
      sharedPreferences.setBool('firstRun', false);
    }
  }

  Future getFirstRun() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    firstRun = (sharedPreferences.getBool('firstRun')) ?? true;
  }

  Future<void> getData(var savedCity, var network) async {
    await savedCity.getLocation();
    int? length = savedCity.cities?.list.length;
    await network.getCMHDWeather(savedCity.cities?.list[length! - 1].coord.lat,
        savedCity.cities?.list[length! - 1].coord.lon);
  }

  void doJobs() async {
    var savedCity = Provider.of<SaveLocation>(context, listen: false);
    var network = Provider.of<Networking>(context, listen: false);
    await getFirstRun();
    if (!firstRun) {
      await getData(savedCity, network);
    } else {
      var loc = Provider.of<LocationService>(context, listen: false);
      await loc.getLocation();
      await network.getCMHDWeather(loc.lat, loc.lon);
      await network.getCityName(loc.lat.toString(), loc.lon.toString());
      await savedCity.saveToStorage(
          network.cityName, loc.lat.toString(), loc.lon.toString());
      await setFirstRun();
    }
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }

  @override
  void initState() {
    super.initState();
    doJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('icons/27.png', width: 250, height: 150),
            SizedBox(height: 50),
            Text(
              'Weatherly',
              style: TextStyle(
                letterSpacing: 1.1,
                color: Colors.white,
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
