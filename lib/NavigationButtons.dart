import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'consts.dart';

class NavigationBarButtons extends StatelessWidget {
  NavigationBarButtons({required this.iconAsset, required this.type});

  String iconAsset;
  int type;

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    if (type == 1) {
      isSelected = true;
    }
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        isSelected
            ? Container(color: Colors.white, width: 20, height: 18)
            : Container(height: 0, width: 0),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              width: 60,
              height: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                  splashRadius: 25,
                  iconSize: 18,
                  focusColor: Colors.black,
                  splashColor: darkGrey,
                  hoverColor: Colors.black,
                  highlightColor: Colors.black,
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  icon: SvgPicture.asset(iconAsset,
                      width: 18, height: 18, color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
