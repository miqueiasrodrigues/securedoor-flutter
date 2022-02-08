// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:project/pages/create_new_account_page.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/pages/login_page.dart';
import 'package:project/provider/users_provider.dart';
import 'package:project/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Users(),
        ),
      ],
      child: MaterialApp(
        title: 'Projeto',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppRoutes.LOGIN,
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.LOGIN: (context) => LoginPage(),
          AppRoutes.HOME: (context) => HomePage(),
          AppRoutes.CREATE_ACCOUNT: (context) => CreateNewAccount(),
        },
      ),
    );
  }
}
