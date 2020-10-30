import 'package:flutter/material.dart';
import 'package:login/API/loginapi.dart';
import 'package:login/helpers/slider/bottomdownsliderprovider.dart';
import 'package:login/helpers/slider/bottomupsliderprovider.dart';
import 'package:login/screens/registration.dart';
import 'package:login/screens/forgotpasswod.dart';
import 'package:login/screens/dashboard.dart';
import 'package:login/screens/setpin.dart';
import 'package:login/screens/verifypin.dart';
import 'package:login/widgets/bottomfirstslider.dart';
import 'package:login/widgets/bottomsecslider.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/sliderightroute.dart';
import 'package:login/widgets/validation.dart';
import 'package:provider/provider.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController = ScrollController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _isLoading = false;

  bool _checked = true;

  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<BottomUpSliderProvider>(context, listen: false)
            .setIcon();
        await Provider.of<BottomDownSliderProvider>(context, listen: false)
            .setIcon();
      } catch (error) {
        print(error);
      }

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double boxSize = size.height > 470 ? 70 : 50;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
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
              _isLoading
                  ? CustomCircularProgressIndicator()
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        padding: size.height > Constant.divSize
                            ? EdgeInsets.only(
                                top: 108, left: 55, right: 55, bottom: 0)
                            : EdgeInsets.all(21),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SingleChildScrollView(
                              child: Container(
                                width:
                                    size.height > Constant.divSize ? 650 : 400,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  child: Column(
                                    children: <Widget>[
                                      size.height > Constant.divSize
                                          ? _formField(
                                              'Email',
                                              650,
                                              30,
                                              'assets/icons/user.png',
                                              _emailController,
                                              false)
                                          : _formField(
                                              'Email',
                                              450,
                                              15,
                                              'assets/icons/user.png',
                                              _emailController,
                                              false),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      size.height > Constant.divSize
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
                                      SizedBox(
                                        height: size.height > Constant.divSize
                                            ? 20
                                            : 5,
                                      ),
                                      Container(
                                        width: size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            rememberMeBox(),
                                            Padding(
                                              padding:
                                                  size.height > Constant.divSize
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
                                      ),
                                      SizedBox(
                                        height: size.height > Constant.divSize
                                            ? 20
                                            : 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              _scaffoldKey.currentState
                                                  .hideCurrentSnackBar();
                                              Navigator.of(context).push(
                                                SlideRightRoute(
                                                  page: ForgotPassword(),
                                                ),
                                              );
                                            },
                                            //Forgot Password
                                            child: customText(size, "Amnesia?"),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _scaffoldKey.currentState
                                                  .hideCurrentSnackBar();
                                              Navigator.push(
                                                context,
                                                SlideRightRoute(
                                                  page: RegistrationScreen(),
                                                ),
                                              );
                                            },
                                            //Join
                                            child: customText(size, "Join?"),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            BottomFirstSlider(
                              boxSize: boxSize,
                              size: size,
                              controller: _scrollController,
                              isLoading: _isLoading,
                            ),
                            BottomSecSlider(
                              size: size,
                              boxSize: boxSize,
                              controller: _scrollController2,
                              isLoading: _isLoading,
                            )
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

  Widget _formField(
    String lable,
    double width,
    double fontSize,
    String image,
    TextEditingController controller,
    bool isSecure,
  ) {
    return Container(
      width: width,
      child: TextFormField(
        cursorColor: Colors.white,
        controller: controller,
        style: TextStyle(color: Colors.yellow[300], fontSize: fontSize),
        obscureText: isSecure,
        decoration:
            CustomInputDecoration.customInputDecoration(lable, fontSize, image),
      ),
    );
  }

  bool validateField(BuildContext context) {
    if (!Validation.shared.isEmailValidation(_emailController.text)) {
      CustomSnackBar(context, Constant.emailMsg, SnackBartype.nagetive);
      return false;
    } else if (_passwordController.text.length <= 0) {
      CustomSnackBar(context, Constant.passwordMsg, SnackBartype.nagetive);
      return false;
    } else {
      return true;
    }
  }

  void _submit(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await Provider.of<LoginApi>(context, listen: false)
          .signIn(
              _emailController.text.trim(), _passwordController.text.trim());
      final statusCode = response[0];
      int setPinScreen = response[1];
      final pinStatus = response[2];
      if (statusCode == 200) {
        _scaffoldKey.currentState.hideCurrentSnackBar();
        print("setpin screen  " + setPinScreen.toString());
        if (setPinScreen == 0) {
          if (pinStatus == 0) {
            Navigator.pushReplacement(
              context,
              SlideRightRoute(
                page: PickRoom(),
              ),
            );
            _emailController.clear();
            _passwordController.clear();
          } else {
            Navigator.pushReplacement(
              context,
              SlideRightRoute(
                page: VerifyPin(),
              ),
            );
            _emailController.clear();
            _passwordController.clear();
          }
        } else {
          Navigator.pushReplacement(
            context,
            SlideRightRoute(
              page: SetPin(),
            ),
          );
        }
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      CustomSnackBar(context, error.toString(), SnackBartype.nagetive);
    }
  }

  Container customText(Size size, String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Constant.primaryColor,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: Constant.primaryColor,
            fontSize: size.height > Constant.divSize ? 25 : 15),
      ),
    );
  }

  GestureDetector rememberMeBox() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _checked ? _checked = false : _checked = true;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Constant.primaryColor),
                left: BorderSide(width: 1.0, color: Constant.primaryColor),
                right: BorderSide(width: 1.0, color: Constant.primaryColor),
                bottom: BorderSide(width: 1.0, color: Constant.primaryColor),
              ),
            ),
            child: Checkbox(
                activeColor: Colors.transparent,
                checkColor: Constant.primaryColor,
                value: _checked,
                onChanged: (value) {
                  setState(() {
                    _checked = value;
                  });
                }),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Remember Me",
            style: TextStyle(color: Constant.primaryColor),
          ),
        ],
      ),
    );
  }
}
