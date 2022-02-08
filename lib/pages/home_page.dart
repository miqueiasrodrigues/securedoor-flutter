// ignore_for_file: prefer_const_constructors

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// ignore: unused_import
import 'package:project/data/dammy_users.dart';
import 'package:project/provider/users_provider.dart';
import 'package:project/routes/app_routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ticket = '';

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');
    if (ticket == 'Laboratorio de eletronica aplicada') {
      await Provider.of<Users>(context, listen: false).open(
          dammyUser['name'], dammyUser['description'], dammyUser['isActive']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          duration: Duration(milliseconds: 2000),
          content: Text('Toque novamente para sair'),
        ),
        child: Column(
          children: [
            Center(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Divider(),
                  ListTile(
                    title: Text('Nome'),
                    leading: Icon(Icons.person_outline_sharp),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(dammyUser['name']),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('E-mail'),
                    leading: Icon(Icons.email_outlined),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(dammyUser['email']),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Descrição'),
                    leading: Icon(Icons.edit_outlined),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(dammyUser['description']),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Situação'),
                    leading: Icon(Icons.wifi_tethering_outlined),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text((dammyUser['isActive'] == true)
                              ? 'Ativo'
                              : 'Inativo'),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.qr_code),
                      onPressed: readQRCode,
                    ),
                    Text('Abrir porta')
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      onPressed: () {
                        Future.delayed(Duration(milliseconds: 250), () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.LOGIN);
                        });
                      },
                    ),
                    Text('Sair')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
