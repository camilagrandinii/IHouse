import 'package:flutter/material.dart';
import 'package:travelappui/views/HomePage/homepage.dart';

import '../../components/header_widget.dart';
import '../../constants/theme_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _secondNameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _emailController = TextEditingController();

Future<void> postUserData(String firstName, String secondName, String password, String email) async {
  final url = Uri.parse('https://localhost:7185/api/Users');
  final headers = {'Content-Type': 'application/json'};
  final data = {'Username': firstName + " " + secondName, 'Email': email, 'Password': password};
  var response;

  try{
    response = await http.post(
    url,
    headers: headers,
    body: json.encode(data),
  );
  }catch(e){
    print('Ocorreu uma exceção: $e');
  }

  if (response.statusCode == 201) {
    print(response.body);
  } else {
    print('Erro ao enviar dados para o servidor.');
  }
}

class _Register extends State<Register> {
final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(117, 138, 217, 241),
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.waving_hand_outlined,
                                  color: Color.fromARGB(255, 158, 220, 245),
                                  size: 80.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            controller: _firstNameController,
                            style: TextStyle(color: Colors.black),
                            decoration: ThemeHelper().textInputDecoration('Primeiro Nome', 'Digite o seu primeiro nome'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            controller: _secondNameController,
                            style: TextStyle(color: Colors.black),
                            decoration: ThemeHelper().textInputDecoration('Sobrenome', 'Digite o seu sobrenome'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: ThemeHelper().textInputDecoration("E-mail", "Digite seu email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              // ignore: prefer_is_not_empty
                              if(!(val.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Digite um email válido!";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _passwordController,
                            style: TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Senha", "Digite a sua senha"),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Por favor, digite a sua senha";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text("Aceito todos os termos e condições.", style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).colorScheme.error,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'Você precisa aceitar os termos e condições!';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Cadastrar".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()
                                    ),
                                        (Route<dynamic> route) => false
                                );
                              }
                              postUserData(_firstNameController.text, _secondNameController.text, _emailController.text, _passwordController.text);
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
