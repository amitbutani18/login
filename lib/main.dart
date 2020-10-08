import 'dart:async';

import 'package:device_simulator/device_simulator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/API/isverifyApi.dart';
import 'package:login/API/loginapi.dart';
import 'package:login/API/logout.dart';
import 'package:login/API/profileapi.dart';
import 'package:login/API/registerapi.dart';
import 'package:login/API/serviceproviderapi.dart';
import 'package:login/API/setpinapi.dart';
import 'package:login/API/verpinapi.dart';
import 'package:login/helpers/slider/bottomdownsliderprovider.dart';
import 'package:login/helpers/slider/bottomupsliderprovider.dart';
import 'package:login/helpers/citylist.dart';
import 'package:login/helpers/iconprovider.dart';
import 'package:login/helpers/imageprovider.dart';
import 'package:login/helpers/slider/leftsideslidericonprovider.dart';
import 'package:login/helpers/membersprovider.dart';
import 'package:login/helpers/projectdetailsprovider.dart';
import 'package:login/helpers/slider/link_provider.dart';
import 'package:login/helpers/slider/rightsidesliderprovider.dart';
import 'package:login/helpers/roomdetailsprovider.dart';
import 'package:login/helpers/roomimageprovider.dart';
import 'package:login/helpers/tabiconprovider.dart';
import 'package:login/helpers/slider/topslidericonprovider.dart';
import 'package:login/helpers/transactionprovider.dart';
import 'package:login/screens/setpin.dart';
import 'package:login/screens/verifypin.dart';
import 'package:login/helpers/Routes/routes.dart';
import 'package:login/screens/loginscreen.dart';
import 'package:login/screens/pickroom.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helpers/constant.dart' as Constant;
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
      providers: [
        ChangeNotifierProvider.value(value: IconProvider()),
        ChangeNotifierProvider.value(value: ImagesProvider()),
        ChangeNotifierProvider.value(value: TabIconProvider()),
        ChangeNotifierProvider.value(value: RoomImageProvider()),
        ChangeNotifierProvider.value(value: TopSliderIconProvider()),
        ChangeNotifierProvider.value(value: LeftSideSliderIconProvider()),
        ChangeNotifierProvider.value(value: RightSideSliderIconProvider()),
        ChangeNotifierProvider.value(value: BottomUpSliderProvider()),
        ChangeNotifierProvider.value(value: BottomDownSliderProvider()),
        ChangeNotifierProvider.value(value: RoomDetailsProvider()),
        ChangeNotifierProvider.value(value: ProjectDetailsProvider()),
        ChangeNotifierProvider.value(value: MembersProvider()),
        ChangeNotifierProvider.value(value: LoginApi()),
        ChangeNotifierProvider.value(value: VerPinApi()),
        ChangeNotifierProvider.value(value: SetPinApi()),
        ChangeNotifierProvider.value(value: RegisterApi()),
        ChangeNotifierProvider.value(value: ProfileApi()),
        ChangeNotifierProvider.value(value: LogOut()),
        ChangeNotifierProvider.value(value: CityList()),
        ChangeNotifierProvider.value(value: TransactionProvider()),
        ChangeNotifierProvider.value(value: LinkProvider()),
        ChangeNotifierProvider.value(value: ServiceProviderApi()),
      ],
      child: _isLoad
          ? CustomCircularProgressIndicator()
          : MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                canvasColor: Colors.transparent,
                cursorColor: Constant.primaryColor,
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

  // Future<List> isVerify(String email) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // final api = sharedPreferences.getString('api');

  //   final response = await http.post(
  //     '${Constant.apiLink}isverify',
  //     body: {
  //       "email": email,
  //     },
  //   );
  //   Map<dynamic, dynamic> map = json.decode(response.body);
  //   print(map);
  //   if (response.body.contains("err")) {
  //     final err = map['err'];
  //     print(err);
  //     throw map['err'];
  //   } else {
  //     if (response.statusCode == 200) {
  //       if (map.containsKey('data')) {
  //         print(map['data']);
  //         SharedPreferences sharedPreferences =
  //             await SharedPreferences.getInstance();
  //         sharedPreferences.setBool('login', true);
  //         sharedPreferences.setString('name', map['data']['name']);
  //         sharedPreferences.setString('email', map['data']['email']);
  //         sharedPreferences.setString("userid", map['data']['userid']);
  //         sharedPreferences.setInt("touchid", map['data']['touchid']);
  //         sharedPreferences.setInt("pinstatus", map['data']['pinstatus']);
  //         sharedPreferences.setInt("setpinscreen", map['data']['setpinscreen']);
  //         sharedPreferences.setInt(
  //             "serviceproviderowner", map['data']['serviceproviderowner']);

  //         // setState(() {
  //         //   user = sharedPreferences.getBool('login');
  //         //   pinstatus = sharedPreferences.getInt("pinstatus");
  //         //   fingStatus = sharedPreferences.getInt("touchid");
  //         //   setpinscreen = sharedPreferences.getInt("setpinscreen");
  //         // });

  //         print(sharedPreferences.getString('name'));
  //         print(sharedPreferences.getString('email'));
  //         print(sharedPreferences.getBool('login'));
  //         print(sharedPreferences.getString('userid'));
  //         print(sharedPreferences.getInt('touchid'));
  //         print(sharedPreferences.getInt('pinstatus'));
  //         print("setpinscreen  " +
  //             sharedPreferences.getInt('setpinscreen').toString());
  //         print(sharedPreferences.getInt("serviceproviderowner"));
  //       }
  //     } else {
  //       throw Exception("fail to load");
  //     }
  //   }

  //   return [
  //     response.statusCode,
  //   ];
  // }

}
