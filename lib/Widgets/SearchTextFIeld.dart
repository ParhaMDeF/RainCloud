import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather/Services/FindCity.dart';
import '../SearchLocationScreen.dart';
import '../consts.dart';

class TextFiled extends StatefulWidget {
  @override
  State<TextFiled> createState() => _TextFiledState();
}

class _TextFiledState extends State<TextFiled> {
  late String cityName;
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var city = Provider.of<FindCity>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) async {
          _focusNode.unfocus();
          await Provider.of<FindCity>(context, listen: false)
              .getResponse(cityName);
          if (city.weatherData == null || city.resCode == 404) {
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
          }
        },
        focusNode: _focusNode,
        autofocus: false,
        onChanged: (input) {
          setState(() {
            cityName = input;
          });
        },
        style: TextStyle(color: grey, fontFamily: 'Roboto', fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () async {
              _focusNode.unfocus();
              await city.getResponse(cityName);
              _focusNode.unfocus();
              if (city.weatherData == null || city.resCode == 404) {
                ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
              }
            },
            icon: SvgPicture.asset(
              'icons/SearchOutline.svg',
              width: 18,
              height: 18,
              color: Colors.white,
            ),
          ),
          filled: true,
          fillColor: Color(0xFF2A2A2A),
          hintText: 'Tehran',
          hintStyle: TextStyle(color: darkGrey),
          focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(25.7)),
          enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(25.7)),
        ),
      ),
    );
  }
}