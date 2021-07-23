import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather/MainScreen.dart';
import 'package:weather/SearchLocationScreen.dart';
import 'package:weather/Services/LocationService.dart';
import 'package:weather/consts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final tabs = [MainScreen(), SearchLocationScreen()];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationService(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: PageTransitionSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                FadeThroughTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    fillColor: Colors.black45.withOpacity(0.2),
                    child: child),
            child: tabs[index],
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: black,
              currentIndex: index,
              onTap: (currentIndex) {
                setState(() {
                  index = currentIndex;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          index == 0 ? navigationBarIconsShadow : BoxShadow(),
                        ],
                      ),
                      child: buildSvgPicture(index == 0
                          ? 'icons/HomeBold.svg'
                          : 'icons/HomeOutline.svg'),
                    ),
                    title: Container()),
                BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          index == 1 ? navigationBarIconsShadow : BoxShadow(),
                        ],
                      ),
                      child: buildSvgPicture(index == 1
                          ? 'icons/SearchBold.svg'
                          : 'icons/SearchOutline.svg'),
                    ),
                    title: Container()),
                // BottomNavigationBarItem(
                //     icon: Container(
                //       decoration: BoxDecoration(
                //         boxShadow: [
                //           index == 2 ? navigationBarIconsShadow : BoxShadow(),
                //         ],
                //       ),
                //       child: buildSvgPicture(index == 2
                //           ? 'icons/SafariBold.svg'
                //           : 'icons/SafariOutline.svg'),
                //     ),
                //     title: Container()),
                // BottomNavigationBarItem(
                //     icon: Container(
                //       decoration: BoxDecoration(
                //         boxShadow: [
                //           index == 3 ? navigationBarIconsShadow : BoxShadow(),
                //         ],
                //       ),
                //       child: buildSvgPicture(index == 3
                //           ? 'icons/UserBold.svg'
                //           : 'icons/UserOutline.svg'),
                //     ),
                //     title: Container()),
              ]),
        ),
      ),
    );
  }

  SvgPicture buildSvgPicture(String iconPath) {
    return SvgPicture.asset(iconPath,
        width: 18, height: 18, color: Colors.white);
  }
}
