import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/API/isverifyApi.dart';
import 'package:login/screens/setpin.dart';
import 'package:login/screens/verifypin.dart';
import 'package:login/screens/loginscreen.dart';
import 'package:login/screens/dashboard.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helpers/Constant/constant.dart';
import 'helpers/Constant/providers_list.dart';
import 'helpers/Constant/routes.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _checkConfiguration() => true;
  var user = true;
  var pinstatus = 0;
  var fingStatus = 1;
  var setpinscreen = 1;
  bool _isVerify = false;
  bool _isLoad = false;
  String _latestLink = 'Unknown';
  Uri _latestUri;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    if (_checkConfiguration()) {
      Future.delayed(Duration.zero, () async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        if (sharedPreferences.getBool('login') == null) {
          sharedPreferences.setBool('login', false);
        }
        setState(() {
          user = sharedPreferences.getBool('login');
          pinstatus = sharedPreferences.getInt("pinstatus");
          fingStatus = sharedPreferences.getInt("touchid");
          setpinscreen = sharedPreferences.getInt("setpinscreen");
        });

        final api = sharedPreferences.getString('api');
        print("Pin Status" + pinstatus.toString());
        print(api);
        print(user);
        print(fingStatus);
        print(setpinscreen);
      });
    }
    initPlatformState();
  }

  initPlatformState() async {
    print("Hello");
    await initPlatformStateForStringUniLinks();
  }

  initPlatformStateForStringUniLinks() async {
    _sub = getLinksStream().listen((String link) {
      if (!mounted) return;
      setState(() {
        print("Amit");
        _latestLink = link ?? 'Unknown';
        _latestUri = null;
        try {
          if (link != null) _latestUri = Uri.parse(link);
        } on FormatException {}
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestLink = 'Failed to get latest link: $err.';
        _latestUri = null;
      });
    });
    getLinksStream().listen((String link) async {
      final email = link.split("//").last;
      if (link != '') {
        print(email);
        setState(() {
          _isLoad = true;
        });
        final response = await IsVerifyApi.shared.isVerify(email);
        // isVerify(email);
        print(response);
        setState(() {
          _isVerify = true;
          _isLoad = false;
        });
      }
      print('got link: $email');
    }, onError: (err) {
      print('got err: $err');
    });
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return MultiProvider(
      providers: ProviderList.providerList,
      child: _isLoad
          ? CustomCircularProgressIndicator()
          : MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                canvasColor: Colors.transparent,
                cursorColor: primaryColor,
              ),
              home:
                  //  DeviceSimulator(
                  //   brightness: Brightness.dark,
                  //   enable: true,
                  // child:
                  _isVerify
                      ? SetPin()
                      : user
                          ? setpinscreen == 1
                              ? SetPin()
                              : pinstatus == 0 ? PickRoom() : VerifyPin()
                          : LoginScreen(),
              // ),
              routes: Routes.routes(),
            ),
    );
  }
}
