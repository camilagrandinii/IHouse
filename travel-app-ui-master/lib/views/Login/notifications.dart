import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationsApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initState() {
    initializeNotifications();
    testNotification();
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('\assets\image\logo-sf.png');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void testNotification() {
    // Simule a alteração da variável no banco de dados local
    final variableValue = true;

    // Verifique se o valor é o esperado
    if (variableValue == true) {
      // Crie a configuração da notificação
      final AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
      );

      final NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      // Agende e exiba a notificação
      flutterLocalNotificationsPlugin.show(
        0,
        'Título da Notificação',
        'Conteúdo da Notificação',
        platformChannelSpecifics,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Teste de Notificação'),
        ),
        body: Center(
          child: Text('Teste de Notificação'),
        ),
      ),
    );
  }
}