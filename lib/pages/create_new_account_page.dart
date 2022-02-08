// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_function_literals_in_foreach_calls, avoid_unnecessary_containers

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/components/snackbar.dart';
import 'package:project/models/user.dart';
import 'package:project/provider/users_provider.dart';
import 'package:project/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:remove_emoji/remove_emoji.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final Map<String, Object> _formData = {};
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final Snackbar _snackbar = new Snackbar();

  bool _isLoading = false;
  String _nameUser = '';

  firstCharacterUpper(String text) {
    List arrayPieces = [];

    String outPut = '';

    text.split(' ').forEach((sepparetedWord) {
      arrayPieces.add(sepparetedWord);
    });

    arrayPieces.forEach((word) {
      word =
          "${word[0].toString().toUpperCase()}${word.toString().substring(1)} ";
      outPut += word;
    });

    return outPut;
  }

  _clearFields() {
    _nameController.clear();
    _passwordController.clear();
    _passwordConfirmController.clear();
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
            : Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 40.0),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  AssetImage('assets/images/user.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30, bottom: 5),
                            child: TextFormField(
                              autofocus: false,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                labelText: 'Nome: ',
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
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Por favor, digite um nome';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _nameUser =
                                    firstCharacterUpper(_nameController.text);
                                _formData['name'] = _nameUser.removemoji.trim();
                              },
                            ),
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
                                    .toUpperCase()
                                    .removemoji;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            child: TextFormField(
                              autofocus: false,
                              decoration: InputDecoration(
                                labelText: 'Descrição: ',
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
                              controller: _descriptionController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Por favor, digite um nome';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _formData['description'] =
                                    _descriptionController;
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
                                    _passwordController.text.removemoji.trim();
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            child: TextFormField(
                              autofocus: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirmar senha: ',
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
                              controller: _passwordConfirmController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Por favor, digite uma senha';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _formData['passwordConfirm'] =
                                    _passwordConfirmController.text.removemoji
                                        .trim();
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
                                // Validate returns true if the form is valid, otherwise false.
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (_formData['password'] !=
                                      _formData['passwordConfirm']) {
                                    _snackbar.snackbar(
                                        'As senhas digitadas não coincidem!',
                                        context,
                                        true);
                                  } else {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    try {
                                      final result =
                                          await InternetAddress.lookup(
                                              'example.com');
                                      if (result.isNotEmpty &&
                                          result[0].rawAddress.isNotEmpty) {
                                        await Provider.of<Users>(context,
                                                listen: false)
                                            .put(
                                          User(
                                            email:
                                                _formData['email'].toString(),
                                            name: _formData['name'].toString(),
                                            password: _formData['password']
                                                .toString(),
                                            description:
                                                _formData['description']
                                                    .toString(),
                                            isActive: true,
                                          ),
                                          _formData['email']
                                              .toString()
                                              .replaceAll('.', ':'),
                                        );
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                AppRoutes.LOGIN);
                                        _clearFields();
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
                                }
                              },
                              child: Text('CRIAR SUA CONTA'),
                            ),
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                _clearFields();
                              },
                              child: Text('VOLTAR'),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
