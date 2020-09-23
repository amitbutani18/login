import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/pagetitle.dart';
import 'package:flutter/cupertino.dart' as ios;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:login/helpers/constant.dart' as Constant;

class SettingScreen extends StatefulWidget {
  static const routeName = '/settings';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double diviceSize = 470;
  bool _load = false;
  var initialValuePin = false;
  var initValFing = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final pinstatus = sharedPreferences.getInt('pinstatus');
    final fingValue = sharedPreferences.getInt('touchid');
    print("Current Pin status" + pinstatus.toString());
    setState(() {
      initialValuePin = pinstatus == 1 ? true : false;
      initValFing = fingValue == 1 ? true : false;
    });
    print(initialValuePin);
    print(initValFing);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black54,
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) => Stack(
          children: <Widget>[
            PageBackground(
                size: size, imagePath: 'assets/icons/loginbackground.png'),
            _load
                ? CustomCircularProgressIndicator()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 10),
                        child: PageTitle(
                            size: size, diviceSize: 470, title: "Settings"),
                      ),
                      Center(
                        child: Container(
                          width: size.width,
                          padding: size.height > diviceSize
                              ? EdgeInsets.only(
                                  top: 108, left: 105, right: 105, bottom: 55)
                              : EdgeInsets.only(
                                  top: 35,
                                  right: size.width < 600 ? 130 : 150,
                                  left: size.width < 600 ? 130 : 200,
                                  bottom: 45),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                // width: size.height > diviceSize ? 650 : 400,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Security Pin Status",
                                      style: TextStyle(
                                        color: Constant.primaryColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 0),
                                      child: Platform.isIOS
                                          ? ios.CupertinoSwitch(
                                              value: initialValuePin,
                                              activeColor: Colors.green,
                                              onChanged: (value) async {
                                                SharedPreferences
                                                    sharedPreferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                setState(() {
                                                  initialValuePin = value;
                                                });
                                                sharedPreferences.setInt(
                                                    'pinstatus', value ? 1 : 0);
                                                _submit(context, 'pin');
                                              })
                                          : Switch(
                                              value: initialValuePin,
                                              activeTrackColor:
                                                  Colors.lightGreenAccent,
                                              activeColor: Colors.green,
                                              onChanged: (value) async {
                                                SharedPreferences
                                                    sharedPreferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                setState(() {
                                                  initialValuePin = value;
                                                });
                                                sharedPreferences.setInt(
                                                    'pinstatus', value ? 1 : 0);
                                                _submit(context, 'pin');
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "FingerPrint Security Status",
                                    style: TextStyle(
                                      color: Constant.primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 0),
                                    child: Platform.isIOS
                                        ? ios.CupertinoSwitch(
                                            value: initValFing,
                                            activeColor: Colors.green,
                                            onChanged: (value) async {
                                              SharedPreferences
                                                  sharedPreferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              setState(() {
                                                initValFing = value;
                                              });
                                              sharedPreferences.setInt(
                                                  'touchid', value ? 1 : 0);
                                              _submit(context, 'finger');
                                            })
                                        : Switch(
                                            value: initValFing,
                                            activeTrackColor:
                                                Colors.lightGreenAccent,
                                            activeColor: Colors.green,
                                            onChanged: (value) async {
                                              SharedPreferences
                                                  sharedPreferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              setState(() {
                                                initValFing = value;
                                              });
                                              sharedPreferences.setInt(
                                                  'touchid', value ? 1 : 0);
                                              _submit(context, 'finger');
                                            },
                                          ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: size.height > diviceSize
                                        ? const EdgeInsets.only(top: 18.0)
                                        : const EdgeInsets.only(top: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: size.height > diviceSize
                                                ? 40
                                                : 30,
                                            child: Image.asset(
                                                'assets/icons/loginbubble.png')),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context, String type) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final api = sharedPreferences.getString('api');
    final userId = sharedPreferences.getString('userid');
    final response = await http.post(
      '${Constant.apiLink}securitystatus',
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "userid": userId,
          "type": type == 'finger' ? 1 : 0,
        },
      ),
    );
    Map<String, dynamic> map = json.decode(response.body);
    print(map);
    if (map.containsKey('err')) {
      print(map['err']);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        print(map['data']);
        _scaffoldKey.currentState.hideCurrentSnackBar();
        CustomSnackBar(
            context,
            map['data'],
            map['data'] == 'pin enable successfully' ||
                    map['data'] == 'Fingarprint enable successfully'
                ? SnackBartype.positive
                : SnackBartype.nagetive);
      }
    }
  }
}
