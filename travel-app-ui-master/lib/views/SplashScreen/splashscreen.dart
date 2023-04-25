import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Timer(Duration(seconds: 5), () {
      Navigator.pushNamed(context, AppRoutes.ROUTE_Login);
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(children: [
        Container(
          height: size.height * 0.6,
          child: SlideTransition(
            position: _offsetAnimation,
            child: ClipRRect(
              child: Image(
                alignment: Alignment.center,
                image: AssetImage('assets/image/logo.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
