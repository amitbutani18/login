import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/API/verpinapi.dart';
import 'package:login/screens/dashboard.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class VerifyPin extends StatefulWidget {
  @override
  _VerifyPinState createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _setPinController = TextEditingController();

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  String _authorizedOrNot = "Not Authorized";
  bool _hasFingerPrintSupport = false;
  List<BiometricType> _availableBuimetricType = List<BiometricType>();

  // var _pin = '';
  var _load = false;

  bool _isinit = true;

  Future<void> _getBiometricsSupport() async {
    // 6. this method checks whether your device has biometric support or not
    bool hasFingerPrintSupport = false;
    try {
      hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _hasFingerPrintSupport = hasFingerPrintSupport;
    });
  }

  Future<void> _getAvailableSupport() async {
    // 7. this method fetches all the available biometric supports of the device
    List<BiometricType> availableBuimetricType = List<BiometricType>();
    try {
      availableBuimetricType =
          await _localAuthentication.getAvailableBiometrics();
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _availableBuimetricType = availableBuimetricType;
    });
  }

  Future<void> _authenticateMe() async {
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PickRoom(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // _authenticateMe();
    // WidgetsBinding.instance.addPostFrameCallback((_) => _authenticateMe());
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    print("Pick Room Did");
    if (_isinit) {
      _getBiometricsSupport();
      _getAvailableSupport();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final fingStatus = sharedPreferences.getInt("touchid");
      print("Touch Id In Pin" + fingStatus.toString());
      if (fingStatus == 1) {
        _authenticateMe();
      }
      // fingStatus == 1 ?
      // _authenticateMe();
    }
    setState(() {
      _isinit = false;
    });
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
              Stack(
                children: [
                  _load ? CustomCircularProgressIndicator() : Container(),
                  Center(
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
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    size.height > Constant.divSize
                                        ? _formField('Enter Pin', 650, 30,
                                            'assets/icons/user.png')
                                        : _formField('Enter Pin', 450, 15,
                                            'assets/icons/user.png'),
                                    SizedBox(
                                      height: 5,
                                    ),
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
                                              if (_load) {
                                                return null;
                                              } else {
                                                if (validateField(context)) {
                                                  _submit(context);
                                                }
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
      ),
    );
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
        // print(_pin);
        int statusCode = await Provider.of<VerPinApi>(context, listen: false)
            .verPin(int.parse(_setPinController.text.trim()));
        if (statusCode == 200) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          final touchid = sharedPreferences.getInt('touchid');
          print("TouchId" + touchid.toString());
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PickRoom(),
            ),
          );
          // }
        }
        setState(() {
          _load = false;
        });
      } catch (error) {
        setState(() {
          _load = false;
        });
        print(error.toString());
        _scaffoldKey.currentState.hideCurrentSnackBar();
        CustomSnackBar(context, error.toString(), SnackBartype.nagetive);
      }
    }
  }

  bool validateField(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_setPinController.text.length != 4) {
      CustomSnackBar(context, Constant.validPin, SnackBartype.nagetive);
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
  ) {
    return Container(
      width: width,
      child: TextFormField(
          enabled: _load ? false : true,
          inputFormatters: [LengthLimitingTextInputFormatter(4)],
          keyboardType: TextInputType.number,
          cursorColor: Colors.white,
          controller: _setPinController,
          style: TextStyle(color: Constant.primaryColor, fontSize: fontSize),
          obscureText: true,
          decoration: CustomInputDecoration.customInputDecoration(
              lable, fontSize, image)),
    );
  }
}
