
import 'package:fluttertoast/fluttertoast.dart';
import '../Login/profile.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import '../../constants/colors.dart';
import '../WeatherPrevision/lib2/mainWeather.dart';

import 'home_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;

  List<Widget> get pages => [
        MainWeather(),
        HomePageContentWidget(),
        ProfilePage(),
      ];
      


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
        color: Color.fromRGBO(2, 166, 231, 0.573),
        alignment: Alignment.center,
        child: Text(
          "IHouse Status",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ),
    ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: MotionTabBar(
        tabOneName: "Previsão do Tempo",
        tabTwoName: "Inicio",
        tabThreeName: "Perfil",
        tabOneIcon: Icons.cloudy_snowing,
        tabTwoIcon: Icons.home,
        tabThreeIcon: Icons.account_circle,
        tabIconColor: kAppBarBackground,
        tabSelectedColor: kOnAccentColor,
        textStyle: TextStyle(color: kOnAccentColor),
      ),
    );
  }
}


