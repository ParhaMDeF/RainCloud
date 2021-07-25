import 'package:flutter/cupertino.dart';
import '../consts.dart';

class WindWidget extends StatelessWidget {
  WindWidget({required this.wind});

  var wind;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Wind',
          style: TextStyle(fontSize: 16.5, color: darkGrey),
        ),
        SizedBox(height: 10),
        Text(
          wind != 'N/A' ? '$wind km/h' : 'N/A',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}