// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  // fontFamily: 'Jannah',
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false, // to me able to edit

    iconTheme: IconThemeData(color: Colors.black),

    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),

    backgroundColor: Colors.white,
    elevation: 0.0,

    systemOverlayStyle: SystemUiOverlayStyle(
      // this related with the above appbar that located in wifi and battery icons that is status bar

      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 20.0
  ),

  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  
);

ThemeData darkTheme = ThemeData(
  // fontFamily: 'Jannah',
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: HexColor('333739'),

  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false, // to me able to edit
    iconTheme: const IconThemeData(color: Colors.white),

    titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold
    ),

    backgroundColor: HexColor('333739'),
    elevation: 0.0,

    systemOverlayStyle: SystemUiOverlayStyle(
      // this related with the above appbar that located in wifi and battery icons that is status bar
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),

  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.deepOrange,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),

  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  
);
