import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color gray = Color(0XFFACACA9);
const Color black = Color(0XFF50505);
const Color grey = Color(0XFFD3D5D4);
const Color darkGrey = Color(0XFF59595A);
const Color gold = Color(0XFFE2C029);
const Color lightBrown = Color(0XFFD3C49C);
const Color purple = Color(0xFF72dbcff);
Map<int, String> days = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};
BoxShadow navigationBarIconsShadow = BoxShadow(
  color: darkGrey.withOpacity(0.2),
  spreadRadius: 12,
  blurRadius: 10,
  offset: Offset(0, 0), // changes position of shadow
);
final errorSnackBar =
    SnackBar(content: Text('city not found'), duration: Duration(seconds: 1));
final saveSnackBar = SnackBar(
    content: Text('City added successfully'), duration: Duration(seconds: 1));
final saveFailedSnackBar = SnackBar(
    content: Text('City not added successfully'), duration: Duration(seconds: 1));