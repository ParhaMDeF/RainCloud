import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/IconManager.dart';
import 'package:weather/consts.dart';
import 'Services/Networking.dart';
import 'Services/SaveLocation.dart';

class NearByCitiesScreen extends StatelessWidget {
  static const String id = 'nearByCitiesScreen';

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Networking>(context).nearbyCities;
    var icon = Provider.of<IconManager>(context).codeToIcon;
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: data?.count ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return CitiesItems(
            asset: icon[data?.list[index].weather[0].icon],
            cityName: data?.list[index].name,
            weatherData: data?.list[index].weather[0].main,
            lat: data?.list[index].coord.lat,
            lon: data?.list[index].coord.lon,
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
          await loc.saveToStorage(cityName, lat.toString(), lon.toString());
          ScaffoldMessenger.of(context).showSnackBar(saveSnackBar);
        },
        child: SvgPicture.asset('icons/Add.svg',
            width: 22, height: 22, color: Colors.white),
      ),
    );
  }
}
