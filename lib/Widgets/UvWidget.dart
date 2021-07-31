import 'package:flutter/cupertino.dart';

import '../consts.dart';

class UvWidget extends StatelessWidget {
  UvWidget({required this.uv});

  var uv;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'UV',
          style: TextStyle(fontSize: 16.5, color: darkGrey),
        ),
        SizedBox(height: 10),
        Text(
          uv != 'N/A' ? '$uv' : 'N/A',
          style: TextStyle(fontSize: 17, color: grey),
        )
      ],
    );
  }
}