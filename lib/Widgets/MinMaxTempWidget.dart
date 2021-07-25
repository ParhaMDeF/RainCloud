import 'package:flutter/cupertino.dart';
import '../consts.dart';

class MinMaxTemp extends StatelessWidget {
  MinMaxTemp({required this.min, required this.max});

  var min, max;

  @override
  Widget build(BuildContext context) {
    if (min != 'N/A' && max != 'N/A') {
      min -= 272;
      max -= 272;
    }
    return Column(
      children: [
        Text(
          'Min/Max',
          style: TextStyle(fontSize: 16.5, color: darkGrey),
        ),
        SizedBox(height: 10),
        Text(
          min != 'N/A' ? '$min/$max' : 'N/A',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}
