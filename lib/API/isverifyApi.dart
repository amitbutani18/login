import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/helpers/constant.dart' as Constant;

class IsVerifyApi {
  // singleton
  static final IsVerifyApi _singleton = IsVerifyApi._internal();
  factory IsVerifyApi() => _singleton;
  IsVerifyApi._internal();
  static IsVerifyApi get shared => _singleton;
  Future<List> isVerify(String email) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // final api = sharedPreferences.getString('api');

    final response = await http.post(
      '${Constant.apiLink}isverify',
      body: {
        "email": email,
      },
    );
    Map<dynamic, dynamic> map = json.decode(response.body);
    print(map);
    if (response.body.contains("err")) {
      final err = map['err'];
      print(err);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        if (map.containsKey('data')) {
          print(map['data']);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setBool('login', true);
          sharedPreferences.setString('name', map['data']['name']);
          sharedPreferences.setString('email', map['data']['email']);
          sharedPreferences.setString("userid", map['data']['userid']);
          sharedPreferences.setInt("touchid", map['data']['touchid']);
          sharedPreferences.setInt("pinstatus", map['data']['pinstatus']);
          sharedPreferences.setInt("setpinscreen", map['data']['setpinscreen']);
          sharedPreferences.setInt(
              "serviceproviderowner", map['data']['serviceproviderowner']);
          sharedPreferences.setInt("type", map['data']['type']);

          print(sharedPreferences.getString('name'));
          print(sharedPreferences.getString('email'));
          print(sharedPreferences.getBool('login'));
          print(sharedPreferences.getString('userid'));
          print(sharedPreferences.getInt('touchid'));
          print(sharedPreferences.getInt('pinstatus'));
          print("setpinscreen  " +
              sharedPreferences.getInt('setpinscreen').toString());
          print(sharedPreferences.getInt("serviceproviderowner"));
        }
      } else {
        throw Exception("fail to load");
      }
    }

    return [
      response.statusCode,
    ];
  }
}
