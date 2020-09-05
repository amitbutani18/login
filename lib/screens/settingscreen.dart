import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double diviceSize = 470;
  bool _load = false;
  var initialValuePin;
  var initValFing;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final pinstatus = sharedPreferences.getInt('pinstatus');
    final fingValue = sharedPreferences.getInt('pinstatus');
    print("Current Pin status" + pinstatus.toString());
    setState(() {
      initialValuePin = pinstatus == 0 ? false : true;
      initValFing = fingValue == 0 ? false : true;
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
      body: Stack(
        children: <Widget>[
          PageBackground(
              size: size, imagePath: 'assets/icons/loginbackground.png'),
          _load
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Container(
                    width: size.width / 2,
                    padding: size.height > diviceSize
                        ? EdgeInsets.only(
                            top: 108, left: 55, right: 55, bottom: 55)
                        : EdgeInsets.all(45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // width: size.height > diviceSize ? 650 : 400,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Security Pin Status",
                                style: TextStyle(
                                  color: Colors.yellow[300],
                                  fontSize: 15,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                child: Switch(
                                  value: initialValuePin,
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                  onChanged: (value) async {
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    setState(() {
                                      initialValuePin = value;
                                    });
                                    sharedPreferences.setInt(
                                        'pinstatus', value ? 1 : 0);
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FingerPrint Security Status",
                              style: TextStyle(
                                color: Colors.yellow[300],
                                fontSize: 15,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              child: Switch(
                                value: initValFing,
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                                onChanged: (value) async {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    initValFing = value;
                                  });
                                  sharedPreferences.setInt(
                                      'touchid', value ? 1 : 0);
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
                                onTap: () => _submit(),
                                child: Container(
                                  child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius:
                                          size.height > diviceSize ? 40 : 30,
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
    );
  }

  Future<void> _submit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final api = sharedPreferences.getString('api');
    final userId = sharedPreferences.getString('userid');
    // print(changedValue);
    // sharedPreferences.setInt('pinstatus', changedValue ? 1 : 0);
    final response = await http.post(
      '${api}securitystatus',
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "userid": userId,
          "type": 0,
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
      }
    }

    Navigator.of(context).pushReplacementNamed('/pickroom');
  }
}
