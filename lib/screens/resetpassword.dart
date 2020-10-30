import 'package:flutter/material.dart';
import 'package:login/API/loginapi.dart';

import 'package:login/helpers/Constant/constant.dart' as Constant;
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  static const roteName = '/resetPassowrd';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _currentPassController = TextEditingController();
  TextEditingController _newPassController = TextEditingController();
  TextEditingController _comfPassController = TextEditingController();

  var _load = false;

  @override
  void dispose() {
    super.dispose();
    _currentPassController.dispose();
    _newPassController.dispose();
    _comfPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/icons/loginbackground.png'),
          fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Builder(
              builder: (context) => _load
                  ? Container(
                      height: size.height,
                      width: size.width,
                      alignment: Alignment.center,
                      child: CustomCircularProgressIndicator())
                  : Container(
                      width: size.width,
                      padding: size.height > Constant.divSize
                          ? EdgeInsets.only(
                              top: 108, left: 55, right: 55, bottom: 55)
                          : EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          PageTitle(size: size, title: "Reset Password"),
                          Container(
                            width: size.height > Constant.divSize ? 650 : 400,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(
                              children: <Widget>[
                                _formField(
                                    'Current Password',
                                    450,
                                    15,
                                    'assets/icons/password.png',
                                    _currentPassController),
                                _formField(
                                    'New Password',
                                    450,
                                    15,
                                    'assets/icons/password.png',
                                    _newPassController),
                                _formField(
                                    'Comfirm Password',
                                    450,
                                    15,
                                    'assets/icons/password.png',
                                    _comfPassController),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: size.height > Constant.divSize
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
                                              radius:
                                                  size.height > Constant.divSize
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
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateField(BuildContext context) {
    if (_currentPassController.text.isEmpty) {
      CustomSnackBar(context, Constant.passwordMsg, SnackBartype.nagetive);
      return false;
    }
    if (_newPassController.text.isEmpty) {
      CustomSnackBar(context, Constant.passwordMsg, SnackBartype.nagetive);
      return false;
    }
    if (_newPassController.text != _comfPassController.text) {
      CustomSnackBar(context, Constant.samePassMsg, SnackBartype.nagetive);
      return false;
    } else {
      return true;
    }
  }

  Future<void> _submit(BuildContext context) async {
    // print(_currentPassController.text);
    // print(_newPassController.text);
    // print(_comfPassController.text);
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    try {
      setState(() {
        _load = true;
      });
      final response = await Provider.of<LoginApi>(context, listen: false)
          .resetPassword(_currentPassController.text.trim(),
              _newPassController.text.trim());
      setState(() {
        _load = false;
      });
      // print(response[1]);
      _showMyDialogMsg(response);
    } catch (error) {
      setState(() {
        _load = false;
      });
      CustomSnackBar(context, error.toString(), SnackBartype.nagetive);
    }
  }

  Future<void> _showMyDialogMsg(String msg) async {
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
                  msg,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(color: Constant.primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      child: TextField(
        obscureText: true,
        cursorColor: Colors.white,
        textInputAction: TextInputAction.next,
        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        controller: controller,
        style: TextStyle(color: Constant.primaryColor, fontSize: fontSize),
        decoration:
            CustomInputDecoration.customInputDecoration(lable, fontSize, image),
      ),
    );
  }
}
