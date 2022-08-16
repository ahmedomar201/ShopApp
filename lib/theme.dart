import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';
ThemeData darkTheme=ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),

  appBarTheme: AppBarTheme(
    elevation: 0,
    titleSpacing: 20,
    iconTheme:IconThemeData(
      color:Colors.white,
      size: 30,
    ),

    color: HexColor('333739'),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness:  Brightness.light,
    ),
  ),

  bottomNavigationBarTheme:BottomNavigationBarThemeData (
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold
      )
  ),
  primarySwatch: defaultColor,
  fontFamily: 'Ahmed',
);
ThemeData lightTheme=ThemeData( scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    iconTheme:IconThemeData(
      color: Colors.black,
      size: 30,
    ),
    elevation: 0,

    color: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness:  Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData (
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
      )
  ),
  primarySwatch: defaultColor,
  fontFamily: 'Ahmed',
);
