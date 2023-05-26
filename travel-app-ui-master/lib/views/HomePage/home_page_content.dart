import 'package:flutter/material.dart';
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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initNotifications();
    fetchData();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const duration = Duration(minutes: 1);
    timer = Timer.periodic(duration, (Timer t) {
      fetchData();
    });
  }

  void initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo-sf.png');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String nomeJanela) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'ALERTA!',
      'Sua janela ($nomeJanela) está aberta e começou a chover!',
      platformChannelSpecifics,
      payload: 'notification',
    );
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://localhost:7185/api/Sensor'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      itemList = List<Item>.from(data.map((item) => Item(
            nome: item['local'],
            janelaAberta: item['isAberta'],
          )));

      for (var item in itemList) {
        if (item.janelaAberta) {
          showNotification(item.nome);
        }
      }
    }
  }

  void editItem() {
    setState(() {
      Item item = itemList[selectedIndex];
      item.nome = nomeController.text;
      nomeController.text = item.nome;
      janelaController.text = item.janelaAberta.toString();
      itemList[selectedIndex] = item;
    });
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
                    janelaIcon = Icon(Icons.window);
                  } else {
                    janelaIcon = Icon(Icons.window_outlined);
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
                            janelaController.text =
                                item.janelaAberta.toString();
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
                                    return EditItemDialog(
                                      item: item,
                                      nomeController: nomeController,
                                      janelaController: janelaController,
                                      onItemEdited: () {
                                        setState(() {
                                          editItem();
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
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

class EditItemDialog extends StatelessWidget {
  final Item item;
  final TextEditingController nomeController;
  final TextEditingController janelaController;
  final Function onItemEdited;

  const EditItemDialog({
    Key key,
    this.item,
    this.nomeController,
    this.janelaController,
    this.onItemEdited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: "Novo Nome",
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              onItemEdited();
            },
            child: Text("Salvar"),
          ),
        ],
      ),
    );
  }
}
