import 'dart:convert';

import 'package:hotel_booking/models/user/user.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class LocalServices {

  Future<bool> checkLoginState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool results = preferences.getBool("hasLogin")!;
    return results;
  }

  Future setInstance({required String key, required type, required value}) async {
    final instance = await SharedPreferences.getInstance();

    switch (type) {
      case String:
        instance.setString(key, value);
        break;
      case List:
        instance.setStringList(key, value);
        break;
      case int:
        instance.setInt(key, value);
        break;
      case bool:
        instance.setBool(key, value);
        break;
    }
  }

  Future getInstance({required String key, required type}) async {
    final instance = await SharedPreferences.getInstance();
    var value;
    switch (type) {
      case String:
        value = instance.getString(key);
        break;
      case List:
        value = instance.getStringList(key);
        break;
      case int:
        value = instance.getInt(key);
        break;
      case bool:
        value = instance.getBool(key);
        break;
    }
    return value;
  }

  Future removeInstance({required String key}) async {
    final instance = await SharedPreferences.getInstance();
    instance.remove(key);
  }

  Future getLocalUserData() async {
    final userData = await getInstance(key: "userData", type: String);
    if (userData != null) {
      final userResults = json.decode(userData);
      print(userResults);
      User user = User.fromMap(userResults);
      return user;
    }
  }



}

LocalServices local = LocalServices();
