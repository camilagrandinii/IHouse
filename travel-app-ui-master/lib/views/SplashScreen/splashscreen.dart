import 'package:flutter/material.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/routes/routes.dart';
import 'package:travelappui/theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(children: [
        Container(
          height: size.height * 0.6,
          child: ClipRRect(
            child: Image(
              image: AssetImage('assets/image/logo-sf.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: size.height * 0.3,
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                  child: Text(
                "Monitore sua casa!",
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: appTheme.textTheme.displayLarge,
              )),
              SizedBox(height: 18),
              Text(
                "Aproveite a facilidade de monitorar na sua casa na palma da sua mão!",
                maxLines: 4,
                overflow: TextOverflow.fade,
                style: appTheme.textTheme.bodyLarge,
              ),
              SizedBox(height: 18),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.ROUTE_Login);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: appTheme.colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 0,
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'PlayFair',
                          fontWeight: FontWeight.bold)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Ir"),
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
