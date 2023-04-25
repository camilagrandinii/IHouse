import 'package:flutter/material.dart';
import 'package:travelappui/views/HomePage/homepage.dart';
import 'package:travelappui/views/Login/login.dart';
import 'package:travelappui/views/Login/profile.dart';
import 'package:travelappui/views/Login/register.dart';
import 'package:travelappui/views/SplashScreen/splashscreen.dart';
import 'package:travelappui/views/ViewDetails/viewDetails.dart';
import 'package:travelappui/views/WeatherPrevision/lib2/mainWeather.dart';

class AppRoutes {


  static const String ROUTE_Initial = ROUTE_Splashscreen;

  static const String ROUTE_Home = "/home";
  static const String ROUTE_Splashscreen = "/splash";
  static const String ROUTE_ViewDetails = "/view";
  static const String ROUTE_Login = "/login";
  static const String ROUTE_Register = "/register";
  static const String ROUTE_Profile = "/profile";
  static const String ROUTE_WeatherDetails = "/weather";


  static Route<dynamic> generateRoutes(RouteSettings settings) {

    switch (settings.name) {
      case ROUTE_Home:
        return MaterialPageRoute(          
            settings: settings, builder: (_) => HomePage());
        break;
      case ROUTE_Splashscreen:
          return MaterialPageRoute(
            settings: settings, builder: (_) => SplashScreen());
        break;
      case ROUTE_ViewDetails:
          return MaterialPageRoute(
            settings: settings, builder: (_) => ViewDetails());
        break;
      case ROUTE_Login:
          return MaterialPageRoute(
            settings: settings, builder: (_) => Login());
      break;
      case ROUTE_Register:
          return MaterialPageRoute(
            settings: settings, builder: (_) => Register());
      break;
      case ROUTE_Profile:
          return MaterialPageRoute(
            settings: settings, builder: (_) => ProfilePage());
      break;
      case ROUTE_WeatherDetails:
          return MaterialPageRoute(
            settings: settings, builder: (_) => MainWeather());
      break;
      default:
      return MaterialPageRoute(          
          settings: settings, builder: (_) => HomePage());
    }
  }
}
