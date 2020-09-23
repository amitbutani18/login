import 'package:login/screens/addproject.dart';
import 'package:login/screens/allcontract.dart';
import 'package:login/screens/endcontract.dart';
import 'package:login/screens/forgotpasswod.dart';
import 'package:login/screens/loginscreen.dart';
import 'package:login/screens/ownprofile.dart';
import 'package:login/screens/pickroom.dart';
import 'package:login/screens/projectDetails.dart';
import 'package:login/screens/roomdetails.dart';
import 'package:login/screens/searchmember.dart';
import 'package:login/screens/serviceprovider.dart';
import 'package:login/screens/settingscreen.dart';
import 'package:login/widgets/datepick.dart';

class Routes {
  static routes() {
    return {
      DatePick.roteName: (context) => DatePick(),
      LoginScreen.routeName: (context) => LoginScreen(),
      PickRoom.routeName: (context) => PickRoom(),
      RoomDetails.routeName: (context) => RoomDetails(),
      AddProject.routeName: (context) => AddProject(),
      ProjectDetails.routeName: (context) => ProjectDetails(),
      SearchMember.routeName: (context) => SearchMember(),
      OwnProfile.routeName: (context) => OwnProfile(),
      ServiceProvider.routeName: (context) => ServiceProvider(),
      EndContract.routeName: (context) => EndContract(),
      AllContract.routeName: (context) => AllContract(),
      SettingScreen.routeName: (context) => SettingScreen(),
      ForgotPassword.roteName: (context) => ForgotPassword(),
    };
  }
}
