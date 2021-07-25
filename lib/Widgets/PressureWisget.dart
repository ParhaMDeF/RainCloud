import 'package:flutter/cupertino.dart';

import '../consts.dart';

class Pressure extends StatelessWidget {
  Pressure({required this.pressure});

  var pressure;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Pressure',
          style: TextStyle(fontSize: 16.5, color: darkGrey),
        ),
        SizedBox(height: 10),
        Text(
          pressure != 'N/A' ? '$pressure hpa' : 'N/A',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}