import 'package:flutter/material.dart';
import 'package:login/API/registerapi.dart';
import 'package:login/widgets/bottomfirstslider.dart';
import 'package:login/widgets/bottomsecslider.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/validation.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _load = false;

  int diviceSize = 470;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black54,
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
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        width: size.width,
                        padding: size.height > diviceSize
                            ? EdgeInsets.only(
                                top: 98, left: 0, right: 0, bottom: 48)
                            : EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SingleChildScrollView(
                              child: Container(
                                width: size.height > diviceSize ? 700 : 450,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  child: Column(
                                    children: <Widget>[
                                      size.height > diviceSize
                                          ? _formField(
                                              'Name',
                                              650,
                                              30,
                                              'assets/icons/user.png',
                                              _nameController,
                                              false)
                                          : _formField(
                                              'Name',
                                              450,
                                              15,
                                              'assets/icons/user.png',
                                              _nameController,
                                              false),
                                      SizedBox(
                                        height:
                                            size.height > diviceSize ? 15 : 5,
                                      ),
                                      size.height > diviceSize
                                          ? _formField(
                                              'Email',
                                              650,
                                              30,
                                              'assets/icons/mail.png',
                                              _emailController,
                                              false)
                                          : _formField(
                                              'Email',
                                              450,
                                              15,
                                              'assets/icons/mail.png',
                                              _emailController,
                                              false),
                                      SizedBox(
                                        height:
                                            size.height > diviceSize ? 15 : 5,
                                      ),
                                      size.height > diviceSize
                                          ? _formField(
                                              'Password',
                                              650,
                                              30,
                                              'assets/icons/password.png',
                                              _passwordController,
                                              true)
                                          : _formField(
                                              'Password',
                                              450,
                                              15,
                                              'assets/icons/password.png',
                                              _passwordController,
                                              true),
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
                                      SizedBox(
                                        height:
                                            size.height > diviceSize ? 20 : 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () =>
                                                Navigator.of(context).pop(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.amber[300],
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                "Members ?",
                                                style: TextStyle(
                                                    color: Colors.amber[300],
                                                    fontSize:
                                                        size.height > diviceSize
                                                            ? 25
                                                            : 15),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            BottomFirstSlider(
                                boxSize: 40.0,
                                controller: _scrollController,
                                deviceSize: diviceSize,
                                size: size),
                            BottomSecSlider(
                                boxSize: 40.0,
                                controller: _scrollController2,
                                deviceSize: diviceSize,
                                size: size),
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
    } else if (_passwordController.text.length <= 0) {
      CustomSnackBar(
          context, 'Please enter valid password', SnackBartype.nagetive);
      return false;
    } else if (_nameController.text.isEmpty) {
      CustomSnackBar(context, 'Please enter valid name', SnackBartype.nagetive);
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
    bool isSecure,
  ) {
    // FocusNode myFocusNode = new FocusNode();
    return Container(
      width: width,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.yellow[300], fontSize: fontSize),
        obscureText: isSecure,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 15,
          ),
          hintText: lable,
          hintStyle: TextStyle(
              color: Colors.amber[300], height: 1, fontSize: fontSize),
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

  var _msg = '';
  void _submit(BuildContext context) async {
    print(DateTime.now());
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    try {
      setState(() {
        _load = true;
      });
      final statusCode = await Provider.of<RegisterApi>(context, listen: false)
          .signUp(_nameController.text.trim(), _emailController.text.trim(),
              _passwordController.text.trim());
      print(statusCode[0]);
      setState(() {
        _msg = statusCode[1];
      });
      if (statusCode[0] == 200) {
        _emailController.clear();
        _nameController.clear();
        _passwordController.clear();
        setState(() {
          _load = false;
        });
        _showMyDialog();
      }
    } catch (error) {
      setState(() {
        _load = false;
      });
      CustomSnackBar(context, error.toString(), SnackBartype.nagetive);
    }
  }

  Future<void> _showMyDialog() async {
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
                  _msg,
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
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        );
      },
    );
  }
}
