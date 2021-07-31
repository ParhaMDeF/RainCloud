import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/IconManager.dart';
import 'package:weather/consts.dart';
import 'Services/Networking.dart';
import 'Services/SaveLocation.dart';

class NearByCitiesScreen extends StatelessWidget {
  NearByCitiesScreen({required this.data});

  static const String id = 'nearByCitiesScreen';
  var data;
  @override
  Widget build(BuildContext context) {
    var icon = IconManager.codeToIcon;
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: data.nearbyCities?.count ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return CitiesItems(
            asset: icon[data.nearbyCities?.list[index].weather[0].icon],
            cityName: data.nearbyCities?.list[index].name,
            weatherData: data.nearbyCities?.list[index].weather[0].main,
            lat: data.nearbyCities?.list[index].coord.lat,
            lon: data.nearbyCities?.list[index].coord.lon,
          );
        },
      )),
    );
  }
}

class CitiesItems extends StatelessWidget {
  CitiesItems({
    required this.asset,
    required this.cityName,
    required this.weatherData,
    required this.lat,
    required this.lon,
  });

  var asset, cityName, weatherData, lat, lon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(asset, width: 35, height: 35),
      title:
          Text(cityName, style: TextStyle(color: Colors.white, fontSize: 17)),
      subtitle: Text(weatherData, style: TextStyle(color: gray, fontSize: 14)),
      trailing: MaterialButton(
        minWidth: 22,
        height: 22,
        padding: EdgeInsets.all(0),
        onPressed: () async {
          var loc = Provider.of<SaveLocation>(context, listen: false);
          var network = Provider.of<Networking>(context, listen: false);
          await loc.saveToStorage(cityName, lat.toString(), lon.toString());
          await loc.getLocation();
          await network.getCMHDWeather(lat.toString(), lon.toString());
          ScaffoldMessenger.of(context).showSnackBar(saveSnackBar);
        },
        child: SvgPicture.asset('icons/Add.svg',
            width: 22, height: 22, color: Colors.white),
      ),
    );
  }
}
