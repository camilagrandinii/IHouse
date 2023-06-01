import 'dart:convert';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:http/http.dart' as http;
import '../../constants/colors.dart';
import '../Login/profile.dart';
import '../WeatherPrevision/lib2/mainWeather.dart';
import 'home_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;
  bool showExampleApp = false;
  bool isAberta = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      var response = await http.get(Uri.parse('https://ihouse.azurewebsites.net/api/Sensor'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          isAberta = data[0]['isAberta'];
        });
        if (isAberta) {
          showNotification();
        }
      }
    } catch (error) {
      // Ocorreu um erro na chamada à API
      print('Erro na chamada da API: $error');
    }
  }

  void showNotification() async {
    await ElegantNotification.info(
      width: 360,
      notificationPosition: NotificationPosition.topLeft,
      animation: AnimationType.fromTop,
      title: Text(
        'ALERTA',
        style: TextStyle(color: Color.fromARGB(255, 240, 8, 8)),
      ),
      description: Text(
        'Verifique suas janelas abertas',
        style: TextStyle(color: Colors.black),
      ),
      onDismiss: () {
        setState(() {
          showExampleApp = true;
        });
      },
    ).show(context);
  }

  void onTabItemSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

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
      body: Stack(
        children: [
          if (isAberta && showExampleApp)
            Container(
              color: Color.fromARGB(255, 255, 255, 255), // Defina a cor de fundo desejada
              child: Center(),
            ),
          if (!showExampleApp)
            IndexedStack(
              index: currentIndex,
              children: [
                MainWeather(),
                HomePageContentWidget(),
                ProfilePage(),
              ],
            ),
        ],
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
        onTabItemSelected: onTabItemSelected,
      ),
    );
  }
}
