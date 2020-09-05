import 'package:flutter/material.dart';
import 'package:login/API/setpinapi.dart';
import 'package:login/screens/verifypin.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class SetPin extends StatefulWidget {
  @override
  _SetPinState createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  double diviceSize = 470;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _setPinController = TextEditingController();
  TextEditingController _verPinController = TextEditingController();

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  var _pin = '';
  var _verPin = '';
  var _load = false;
  String _authorizedOrNot = "Not Authorized";
  bool _hasFingerPrintSupport = false;
  List<BiometricType> _availableBuimetricType = List<BiometricType>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _authenticateMe() async {
    // 8. this method opens a dialog for fingerprint authentication.
    //    we do not need to create a dialog nut it popsup from device natively.
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Authenticate User", // message for dialog
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
    if (authenticated) {}
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
                    padding: size.height > diviceSize
                        ? EdgeInsets.only(
                            top: 108, left: 55, right: 55, bottom: 55)
                        : EdgeInsets.all(45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
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
                                      ? _formField('Enter Pin', 650, 30,
                                          'assets/icons/user.png')
                                      : _formField('Enter Pin', 450, 15,
                                          'assets/icons/user.png'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  size.height > diviceSize
                                      ? _formField('Reenter Pin', 650, 30,
                                          'assets/icons/user.png')
                                      : _formField('Re Enter Pin', 450, 15,
                                          'assets/icons/user.png'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: size.height > diviceSize
                                            ? const EdgeInsets.only(top: 18.0)
                                            : const EdgeInsets.only(top: 8.0),
                                        child: GestureDetector(
                                          onTap: () => _submit(_pin),
                                          child: Container(
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
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
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> _submit(String pin) async {
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
        final response = await Provider.of<SetPinApi>(context, listen: false)
            .setPin(int.parse(_pin));
        if (response == 200) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerifyPin(),
            ),
          );
        }
        print(_pin);
        print(_verPin);
        setState(() {
          _load = false;
        });
      } catch (error) {
        print(error);
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              error.toString(),
            ),
          ),
        );
      }
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
        validator: lable == 'Enter Pin'
            ? (value) {
                if (value.isEmpty) {
                  return 'Please Enter Valid Email';
                }
                return null;
              }
            : (value) {
                if (_verPin != _pin || value.isEmpty) {
                  return 'Please Enter Same Pin';
                }
                return null;
              },
        cursorColor: Colors.white,
        controller:
            lable == 'Enter Pin' ? _setPinController : _verPinController,
        onChanged: (value) {
          setState(() {
            lable == 'Enter Pin' ? _pin = value : _verPin = value;
          });
        },
        style: TextStyle(color: Colors.yellow[300], fontSize: fontSize),
        obscureText: true,
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
