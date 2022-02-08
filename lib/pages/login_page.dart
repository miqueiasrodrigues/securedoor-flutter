// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:io';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:project/components/snackbar.dart';
import 'package:project/data/dammy_users.dart';
import 'package:project/provider/users_provider.dart';
import 'package:project/routes/app_routes.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, Object> _formData = {};
  // ignore: unnecessary_new
  final Snackbar _snackbar = new Snackbar();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<Users>(context, listen: false).login();
  }

  Future<void> _getUser(String _user, String _passwd) async {
    dammyUser.clear();
    Map<String, dynamic> _data =
        Provider.of<Users>(context, listen: false).userData();
    bool validationEmail = false;
    bool validationPasswd = false;
    _data.forEach((key, value) {
      if (_user == key) {
        validationEmail = true;

        value.forEach((key2, value2) {
          value2.forEach((key3, value3) {
            if (_passwd == value3) {
              validationPasswd = true;
              dammyUser = value2 as Map<String, dynamic>;
            }
          });
        });
      }
    });
    if (validationEmail == true && validationPasswd == true) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
      _clearFields();
    } else {
      if (validationEmail == true) {
        _snackbar.snackbar('E-mail e senha não coincidem!', context, true);
      } else {
        _snackbar.snackbar('E-mail não cadastrado!', context, true);
      }
      return;
    }
  }

  _clearFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : DoubleBackToCloseApp(
                snackBar: SnackBar(
                  duration: Duration(milliseconds: 2000),
                  content: Text('Toque novamente para sair'),
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 40.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 60.0, bottom: 30.0),
                              width: 180,
                              height: 200,
                              child: Image.asset('assets/images/team.png'),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText: 'E-mail: ',
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Por favor, digite um e-mail';
                                  } else if (!value.contains('@')) {
                                    return 'Por favor, digite um e-mail válido';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _formData['email'] = _emailController.text
                                      .trim()
                                      .toUpperCase();
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Senha: ',
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Por favor, digite uma senha';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _formData['password'] =
                                      _passwordController.text;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30.0, bottom: 40.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  minimumSize: Size(double.infinity, 50),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    _formKey.currentState!.save();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    try {
                                      final result =
                                          await InternetAddress.lookup(
                                              'example.com');
                                      if (result.isNotEmpty &&
                                          result[0].rawAddress.isNotEmpty) {
                                        _getUser(
                                            _formData['email']
                                                .toString()
                                                .replaceAll('.', ':'),
                                            _formData['password'].toString());
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    } on SocketException catch (_) {
                                      _snackbar.snackbar(
                                          'Sem internet. Não foi possível conectar-se a rede',
                                          context,
                                          true);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }
                                },
                                child: Text('ENTRAR'),
                              ),
                            ),
                            Container(
                              child: TextButton(
                                onPressed: () async {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.CREATE_ACCOUNT);
                                  _clearFields();
                                },
                                child: Text('CRIAR SUA CONTA'),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
