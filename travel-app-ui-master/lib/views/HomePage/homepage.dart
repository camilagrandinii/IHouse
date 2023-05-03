import 'package:flutter/material.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../components/appbar.dart';
import '../../constants/colors.dart';
import '../Login/profile.dart';
import '../WeatherPrevision/lib2/mainWeather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;

  List<Widget> get pages => [
    MainWeather(),
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
        textStyle: TextStyle(color: kOnAccentColor),
        onTabItemSelected: onTabItemSelected,
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class Item {
  String nome;
  String tag;
    Color cor;

  Item({this.nome, this.tag,this.cor});
}

class _HomePageContentState extends State<HomePageContent> {
  List<Item> itemList = [];
  String searchTag = '';
  final nomeController = TextEditingController();
  final tagController = TextEditingController();
  int selectedIndex = -1;

  void addItem() {
    setState(() {
      itemList.add(Item(nome: nomeController.text, tag: tagController.text));
      nomeController.text = "";
      tagController.text = "";
    });
  }

  void editItem() {
    setState(() {
      nomeController.text = itemList[selectedIndex].nome;
      tagController.text = itemList[selectedIndex].tag;
      Item item = itemList[selectedIndex];
      item.nome = nomeController.text;
      item.tag = tagController.text;
    });
  }


  void deleteItem(int index) {
    setState(() {
      itemList.removeAt(selectedIndex);
      selectedIndex = -1;
      nomeController.text = "";
      tagController.text = "";
    });
  }

  void _showAddItemDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Color selectedColor = Colors.grey;
      return AlertDialog(
        title: Text('Adicionar Janela'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: "Nome",
              ),
              style: TextStyle(color: Colors.black),
            ),
            TextField(
              controller: tagController,
              decoration: InputDecoration(
                labelText: "Tag",
              ),
              style: TextStyle(color: Colors.black),
            ),
            ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  selectedColor = color;
                });
              },
              // ignore: deprecated_member_use
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  itemList.add(Item(
                    nome: nomeController.text,
                    tag: tagController.text,
                    cor: selectedColor,
                  ));
                  nomeController.text = "";
                  tagController.text = "";
                });
                Navigator.pop(context);
              },
              child: Text("Adicionar"),
            ),
          ],
        ),
      );
    },
  );
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        _showAddItemDialog();
      },
      child: Icon(Icons.add),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                Item item = itemList[index];
                Color cor = item.cor ?? Color.fromARGB(255, 147, 188, 241); 
                switch (item.tag) {
                  case "Quarto":
                    cor = Colors.green;
                    break;
                  case "Sala":
                    cor = Colors.blue;
                    break;
                }
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  child: ListTile(
                    title: Text(
                      item.nome,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      item.tag,
                      style: TextStyle(
                        color: cor,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        nomeController.text = item.nome;
                        tagController.text = item.tag;
                      });
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.black),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Editar Item'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DefaultTextStyle(
                                        style: TextStyle(color: Colors.black),
                                        child: Column(
                                          children: [
                                            Text("Nome: ${item.nome}"),
                                            Text("Tag: ${item.tag}"),
                                          ],
                                        ),
                                      ),
                                      TextField(
                                        controller: nomeController,
                                        decoration: InputDecoration(
                                          labelText: "Novo nome",
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextField(
                                        controller: tagController,
                                        decoration: InputDecoration(
                                          labelText: "Nova tag",
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancelar'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        editItem();
                                        Navigator.pop(context);
                                      },
                                      child: Text('Salvar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              itemList.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}