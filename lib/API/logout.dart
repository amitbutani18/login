import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut with ChangeNotifier {
  Future<void> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('login', false);
    sharedPreferences.clear();
    sharedPreferences.setString('api', "http://3.15.39.127:3000/API/");
  }
}
