import 'package:flutter/material.dart';
import 'package:gastos/transacao.dart';
import 'package:gastos/transacoesWidget.dart';
import 'NovaTransacao.dart';
import 'TransacaoUsuario.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gastos")),
      body: TransacaoUsuario(),
    );
  }
}