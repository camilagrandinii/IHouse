import 'package:flutter/material.dart';
import 'package:travelappui/constants/colors.dart';

ThemeData kAppTheme = ThemeData(
  primaryColor: kPrimaryColor,
  highlightColor: kHighlightColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0
  ),
  fontFamily: 'PlayFair',
  
  textTheme: TextTheme(     
     displayLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 34,),
     displayMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26,),
     displaySmall: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20 ), 
     headlineMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13, fontFamily: 'Roboto'),
     headlineSmall: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16, ),
     titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, ),
     titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13, ),
     bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15, fontFamily: 'Roboto',height: 1.4),
     bodySmall: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Roboto'),
  )
);