import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/consts.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer(this.data, this.network);

  var data, network;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(12),
          color: Colors.black87,
          child: Column(
            children: [
              SizedBox(height: 15),
              Center(
                  child: Text('Recent Cities',
                      style: TextStyle(color: darkGrey, fontSize: 27))),
              SizedBox(height: 15),
              ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: data.cities?.list.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return RecentCity(
                      index: index,
                      data: data,
                      network: network,
                      cityName: data.cities?.list[index].name);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentCity extends StatelessWidget {
  RecentCity(
      {required this.cityName,
      required this.network,
      required this.index,
      required this.data});

  var cityName, network, data;
  int index;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          if (cityName != data.savedCity.last) {
            Navigator.pop(context);
            await network.getCMHDWeather(data.cities?.list[index].coord.lat,
                data.cities?.list[index].coord.lon);
            data.savedCity?.remove(cityName);
            data.savedCity?.add(cityName);
          } else
            Navigator.pop(context);
        },
        child: ListTile(
          trailing: SvgPicture.asset(
            'icons/Sun.svg',
            width: 18,
            height: 18,
            color: gold,
          ),
          title: Text(cityName, style: TextStyle(color: gray, fontSize: 16)),
        ));
  }
}
