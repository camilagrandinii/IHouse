import 'package:flutter/material.dart';
import 'models/task.dart';
import 'widgets/card_widget.dart';
import 'widgets/form_widget.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:travelappui/components/appbar.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/views/HomePage/state/homepageScrollListner.dart';
import '../Login/login.dart';
import '../Login/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;

  List<Widget> get pages => [
    Login(), 
    HomePageContent(),
    ProfilePage(),
  ];

  void onTabItemSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: HomeAppBar,
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
        textStyle: TextStyle(color:kOnAccentColor),
        onTabItemSelected: onTabItemSelected, 
      ),
    );
  }
}

// ignore: must_be_immutable
class HomePageContent extends StatelessWidget {
  // ignore: unused_field
  HomepageSrollListner _model;
  final newList = listTask.where((element) => !element.isDone).toList();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              left: 16,
              child: Container(
                width: size.width - 32,
                height: size.height / 0.4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    right: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    itemBuilder: (context, index) {
                      
                      return CardWidget(
                        task: newList[index],
                      );
                    },
                    itemCount: newList.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const FormWidget();
              });
        },
        backgroundColor: const Color(0xff2da9ef),
        foregroundColor: const Color(0xffffffff),
        child: const Icon(
          Icons.add,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}