import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/API/setpinapi.dart';
import 'package:login/screens/dashboard.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:login/helpers/Constant/constant.dart' as Constant;

class SetPin extends StatefulWidget {
  @override
  _SetPinState createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _setPinController = TextEditingController();
  TextEditingController _verPinController = TextEditingController();

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  var _load = false;
  String _authorizedOrNot = "Not Authorized";
  bool _hasFingerPrintSupport = false;
  List<BiometricType> _availableBuimetricType = List<BiometricType>();

  Future<void> _authenticateMe(BuildContext context) async {
    // 8. this method opens a dialog for fingerprint authentication.
    //    we do not need to create a dialog nut it popsup from device natively.
    bool authenticated = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userName = sharedPreferences.getString("name");
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason:
            "Hello $userName, Enter Fingerprint", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
      );
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
    });
    if (authenticated) {
      enableFinger(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PickRoom(),
        ),
      );
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PickRoom(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black54,
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: <Widget>[
              PageBackground(
                  size: size, imagePath: 'assets/icons/loginbackground.png'),
              _load
                  ? CustomCircularProgressIndicator()
                  : Center(
                      child: Container(
                        padding: size.height > Constant.divSize
                            ? EdgeInsets.only(
                                top: 108, left: 55, right: 55, bottom: 55)
                            : EdgeInsets.all(45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: size.height > Constant.divSize ? 650 : 400,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Column(
                                  children: <Widget>[
                                    size.height > Constant.divSize
                                        ? _formField(
                                            'Enter Pin',
                                            650,
                                            30,
                                            'assets/icons/password.png',
                                            _setPinController)
                                        : _formField(
                                            'Enter Pin',
                                            450,
                                            15,
                                            'assets/icons/password.png',
                                            _setPinController),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    size.height > Constant.divSize
                                        ? _formField(
                                            'Reenter Pin',
                                            650,
                                            30,
                                            'assets/icons/password.png',
                                            _verPinController)
                                        : _formField(
                                            'Re Enter Pin',
                                            450,
                                            15,
                                            'assets/icons/password.png',
                                            _verPinController),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: size.height >
                                                  Constant.divSize
                                              ? const EdgeInsets.only(top: 18.0)
                                              : const EdgeInsets.only(top: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (validateField(context)) {
                                                _submit(context);
                                              }
                                            },
                                            child: Container(
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  radius: size.height >
                                                          Constant.divSize
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
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext pageContext) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: Color.fromRGBO(37, 36, 41, 1),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "You Want To Add Fingerprint Authentication?",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                _authenticateMe(pageContext);
              },
              child: Container(
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Image.asset('assets/icons/Acept.png')),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            GestureDetector(
              onTap: () {
                // sharedPreferences.setInt('touchid', 0);
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => PickRoom(),
                  ),
                );
              },
              child: Container(
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Image.asset('assets/icons/Decline.png')),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> enableFinger(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final api = sharedPreferences.getString('api');
    final userId = sharedPreferences.getString('userid');
    final response = await http.post(
      '${Constant.apiLink}securitystatus',
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "userid": userId,
          "type": 1,
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
        sharedPreferences.setInt('touchid', 1);

        // _scaffoldKey.currentState.hideCurrentSnackBar();
        // _scaffoldKey.currentState
        //     .showSnackBar(new SnackBar(content: Text(map['data'])));
        CustomSnackBar(context, map['data'], SnackBartype.positive);
      }
    }
  }

  Future<void> _submit(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    try {
      setState(() {
        _load = true;
      });
      final response = await Provider.of<SetPinApi>(context, listen: false)
          .setPin(int.parse(_setPinController.text));
      if (response == 200) {
        _showMyDialog(context);
      }
      setState(() {
        _load = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _load = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
    }
  }

  bool validateField(BuildContext context) {
    if (_setPinController.text.length != 4) {
      CustomSnackBar(context, Constant.pinMsg, SnackBartype.nagetive);
      return false;
    } else if (_setPinController.text != _verPinController.text) {
      CustomSnackBar(context, Constant.pinCompareMsg, SnackBartype.nagetive);
      return false;
    } else {
      return true;
    }
  }

  Widget _formField(
    String lable,
    double width,
    double fontSize,
    String image,
    TextEditingController controller,
  ) {
    return Container(
      width: width,
      child: TextFormField(
          keyboardType: TextInputType.number,
          cursorColor: Colors.white,
          controller: controller,
          style: TextStyle(color: Constant.primaryColor, fontSize: fontSize),
          obscureText: true,
          decoration: CustomInputDecoration.customInputDecoration(
              lable, fontSize, image)),
    );
  }
}
