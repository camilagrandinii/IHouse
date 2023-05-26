import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import '../../components/header_widget.dart';
import '../../constants/theme_helper.dart';
import '../../routes/routes.dart';
import '../../constants/theme_helper.dart';
import '../../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double _headerHeight = 250;
    Key _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login),
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(30.0),
                                  child: Column(children: <Widget>[
                                    FadeAnimation(
                                        1.8,
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        125, 217, 253, 0.575),
                                                    blurRadius: 20.0,
                                                    offset: Offset(0, 10))
                                              ]),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    202,
                                                                    202,
                                                                    202)))),
                                                child: TextField(
                                                    controller:
                                                        _emailController,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Usuário ou E-mail",
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextField(
                                                  controller:
                                                      _passwordController,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Senha",
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0))),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  obscureText: true,
                                                ),
                                              )
                                            ],
                                          ),
                                        ))
                                  ])),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Entrar'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    var loginResult = await login(
                                        _emailController.text,
                                        _passwordController.text);

                                    if (loginResult == true) {
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.ROUTE_Home);
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Não possui um cadastro? "),
                                  TextSpan(
                                    text: 'Criar',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.ROUTE_Register);
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

User decode(var jsonString) {
  var jsonObject = json.decode(jsonString);
  return User(
    id: jsonObject['id'],
    nome: jsonObject['username'],
    email: jsonObject['email'],
    teste: true,
  );
}

Future<bool> login(String email, String password) async {
  Uri getUserDataUrl = Uri.parse('https://localhost:7185/api/Users/$email');
  final response = await http.get(getUserDataUrl);

  var responseJson = response.body.parseJSON();
  var userPassword = responseJson['password'];

  if (response.statusCode == 200 && userPassword == password) {
    print(response.body);
    User usuario = decode(response.body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nome', usuario.nome);
    prefs.setString('email', usuario.email);

    return Future.value(true);
    
  } else if (response.statusCode == 200 && userPassword != password) {
    Fluttertoast.showToast(
      msg: "Senha incorreta! Por favor tente novamente.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Color.fromRGBO(125, 217, 253, 0.575),
      textColor: Colors.black,
      fontSize: 16.0,
    );
    print('Usuário e/ou senha incorreto(s)');
    return Future.value(false);
  } else if (response.statusCode == 404) {
    Fluttertoast.showToast(
      msg: "Cadastro não encontrado.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Color.fromRGBO(125, 217, 253, 0.575),
      textColor: Colors.black,
      fontSize: 16.0,
    );
    print('Usuário não cadastrado');
    return Future.value(false);
  }
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}
