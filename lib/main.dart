import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:login/widgets/Routes/routes.dart';
import 'package:login/screens/loginscreen.dart';
import 'package:login/screens/pickroom.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helpers/constant.dart' as Constant;

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

  @override
  void initState() {
    super.initState();
    if (_checkConfiguration()) {
      Future.delayed(Duration.zero, () async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        if (sharedPreferences.getBool('login') == null) {
          sharedPreferences.setBool('login', false);
          sharedPreferences.setString('api', "http://3.15.39.127:3000/API/");
        }
        setState(() {
          user = sharedPreferences.getBool('login');
          pinstatus = sharedPreferences.getInt("pinstatus");
          fingStatus = sharedPreferences.getInt("touchid");
          setpinscreen = sharedPreferences.getInt("setpinscreen");
          sharedPreferences.setString('api', "http://3.15.39.127:3000/API/");
        });

        final api = sharedPreferences.getString('api');
        print("Pin Status" + pinstatus.toString());
        print(api);
        print(user);
        print(fingStatus);
        print(setpinscreen);
      });
    }
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: Colors.transparent,
          cursorColor: Constant.primaryColor,
        ),
        home: user
            ? setpinscreen == 1
                ? SetPin()
                : pinstatus == 0 ? PickRoom() : VerifyPin()
            : LoginScreen(),
        routes: Routes.routes(),
      ),
    );
  }
}
