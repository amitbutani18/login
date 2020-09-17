import 'package:flutter/material.dart';
import 'package:login/API/loginapi.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/pagetitle.dart';
import 'package:login/widgets/validation.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int diviceSize = 470;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  var _load = false;

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
                        padding: size.height > diviceSize
                            ? EdgeInsets.only(
                                top: 108, left: 55, right: 55, bottom: 55)
                            : EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            PageTitle(
                                size: size,
                                diviceSize: diviceSize,
                                title: "Amnesia"),
                            Container(
                              width: size.height > diviceSize ? 650 : 400,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      size.height > diviceSize
                                          ? _formField(
                                              'Email',
                                              650,
                                              30,
                                              'assets/icons/user.png',
                                              _emailController)
                                          : _formField(
                                              'Email',
                                              450,
                                              15,
                                              'assets/icons/user.png',
                                              _emailController),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: size.height > diviceSize
                                                ? const EdgeInsets.only(
                                                    top: 18.0)
                                                : const EdgeInsets.only(
                                                    top: 8.0),
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
                                                        size.height > diviceSize
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

  bool validateField(BuildContext context) {
    if (!Validation.shared.isEmailValidation(_emailController.text)) {
      CustomSnackBar(
          context, 'Please enter valid email', SnackBartype.nagetive);
      return false;
    } else {
      return true;
    }
  }

  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      try {
        setState(() {
          _load = true;
        });
        final response = await Provider.of<LoginApi>(context, listen: false)
            .forgotPassword(_emailController.text.trim());
        setState(() {
          _load = false;
        });
        print(response[1]);
        _showMyDialogMsg(response[1]);
      } catch (error) {
        setState(() {
          _load = false;
        });
        CustomSnackBar(context, error.toString(), SnackBartype.nagetive);
      }
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
                style: TextStyle(color: Colors.amber),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
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
      child: TextFormField(
        // validator: (value) {
        //   if (!EmailValidator.validate(value) || value.isEmpty) {
        //     return 'Please enter valid email';
        //   }
        //   return null;
        // },
        cursorColor: Colors.white,
        controller: controller,
        // onChanged: (value) {
        //   setState(() {
        //     _email = value;
        //   });
        // },
        style: TextStyle(color: Colors.yellow[300], fontSize: fontSize),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 15,
          ),
          hintText: lable,
          hintStyle: TextStyle(color: Colors.amber[300], fontSize: fontSize),
          prefixIcon: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 10,
              child: Image.asset(image),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
      ),
    );
  }
}
