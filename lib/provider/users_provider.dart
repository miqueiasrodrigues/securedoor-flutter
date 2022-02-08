import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:project/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

class Users with ChangeNotifier {
  static const _baseUrl =
      '';
  final Map<String, User> _items = {};
  Map<String, dynamic> data = {};
  Map<String, dynamic> listOpen = {};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int index) {
    return _items.values.elementAt(index);
  }

  Map<String, dynamic> userData() {
    return data;
  }

  Future<void> login() async {
    final response = await get(Uri.parse("$_baseUrl/users.json"));

    try {
      data = json.decode(response.body);
    } catch (e) {
      data = {};
    }
  }

  Future<void> open(String _user, String _description, bool _situation) async {
    await post(
      Uri.parse("$_baseUrl/registerTemp.json"),
      body: json.encode({
        'name': _user,
        'description': _description,
        'situation': _situation,
        'date': DateFormat('dd-MM-yyyy hh:mm:ss a')
            .format(DateTime.now())
            .toString()
            .toString(),
      }),
    );
    await post(
      Uri.parse("$_baseUrl/register.json"),
      body: json.encode({
        'name': _user,
        'description': _description,
        'situation': _situation,
        'date': DateFormat('dd-MM-yyyy hh:mm:ss a')
            .format(DateTime.now())
            .toString()
            .toString(),
      }),
    );
  }

  Future<void> load() async {
    final response = await get(Uri.parse("$_baseUrl/users.json"));

    try {
      data = json.decode(response.body);
    } catch (e) {
      data = {};
    }

    // ignore: unnecessary_null_comparison
    _items.clear();
    // ignore: unnecessary_null_comparison
    if (data != null) {
      data.forEach((userId, userDate) {
        _items.putIfAbsent(
          userId,
          () => User(
            id: userId,
            name: userDate['name'],
            email: userDate['email'],
            password: userDate['password'],
            description: userDate['description'],
            isActive: userDate['isActive'],
          ),
        );
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> put(User _user, String _userId) async {
    // ignore: unnecessary_null_comparison
    if (_user == null) {
      return;
    }
    // ignore: unnecessary_null_comparison
    if (_user.id != null &&
        _user.id.trim().isNotEmpty &&
        _items.containsKey(_user.id)) {
      return;
    } else {
      await post(
        Uri.parse("$_baseUrl/users/$_userId.json"),
        body: json.encode({
          'name': _user.name,
          'email': _user.email,
          'password': _user.password,
          'description': _user.description,
          'isActive': _user.isActive,
        }),
      );
      _items.putIfAbsent(
        _userId,
        () => User(
          id: _userId,
          name: _user.name,
          email: _user.email,
          password: _user.password,
          description: _user.description,
          isActive: _user.isActive,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> remove(User _user) async {
    // ignore: unnecessary_null_comparison
    if (_user != null && _user.id != null) {
      _items.remove(_user.id);
      notifyListeners();
    }
  }
}
