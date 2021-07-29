import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'Services/SaveLocation.dart';
import 'Widgets/DateAndLocation.dart';
import 'Widgets/HourlyForsCast.dart';
import 'Widgets/WeatherInfo.dart';

// DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch)
class MainScreen extends StatefulWidget {
  static const String id = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<SaveLocation>(context);
    int? length = data.cities?.list.length;
    print(data.cities?.list[length! - 1].name);
    String? cityName = data.cities?.list[length! - 1].name ?? 'N/A';

    return Padding(
      padding: EdgeInsets.all(11.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DateAndLocation(cityName: cityName),
          WeatherInfo(),
          HourlyForsCast(),
        ],
      ),
    );
  }
}
