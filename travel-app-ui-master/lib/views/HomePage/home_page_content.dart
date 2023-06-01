import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Item {
  String nome;
  bool janelaAberta;

  Item({this.nome, this.janelaAberta});
}

class HomePageContentWidget extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContentWidget> {
  List<Item> itemList = [];
  String searchTag = '';
  final nomeController = TextEditingController();
  final janelaController = TextEditingController();
  int selectedIndex = -1;
  Timer timer;
  
  @override
  void initState() {
    super.initState();
    fetchWindows();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    showAlert();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> fetchWindows() async {
    final response = await http.get(Uri.parse('https://ihouse.azurewebsites.net/api/Sensor'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      itemList = List<Item>.from(data.map((item) => Item(
            nome: item['local'],
            janelaAberta: item['isAberta'],
          )));
      setState(() {});
      showAlert();    
      }
  }

  void showAlert() {
    Item selectedItem = itemList[selectedIndex];
    if (selectedItem.janelaAberta) {
      Fluttertoast.showToast(
        msg: 'A janela está aberta!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 35.0,
      );
  }
}


  

  void editItem() {
    setState(() {
      Item item = itemList[selectedIndex];
      item.nome = nomeController.text;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  Item item = itemList[index];
                  Widget janelaIcon;
                  if (item.janelaAberta) {
                    janelaIcon = Icon(Icons.water_damage);
                  } else {
                    janelaIcon = Icon(Icons.other_houses_rounded);
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ListTile(
                        title: Text(
                          item.nome,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        leading: janelaIcon,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            nomeController.text = item.nome;
                          });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Editar Item'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      controller: nomeController,
                                      decoration: InputDecoration(
                                        labelText: "Novo Nome",
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        editItem();
                                      },
                                      child: Text("Salvar"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              nomeController.text = item.nome;
                            });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Editar Item'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        controller: nomeController,
                                        decoration: InputDecoration(
                                          labelText: "Novo Nome",
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () {
                                          editItem();
                                        },
                                        child: Text("Salvar"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(Icons.edit, color: Colors.black),
                        ),
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