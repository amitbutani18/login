import 'package:login/API/loginapi.dart';
import 'package:login/API/logout.dart';
import 'package:login/API/profileapi.dart';
import 'package:login/API/registerapi.dart';
import 'package:login/API/serviceproviderapi.dart';
import 'package:login/API/setpinapi.dart';
import 'package:login/API/verpinapi.dart';
import 'package:login/helpers/Providers/imageprovider.dart';
import 'package:login/helpers/Providers/membersprovider.dart';
import 'package:login/helpers/Providers/notification_provider.dart';
import 'package:login/helpers/Providers/projectdetailsprovider.dart';
import 'package:login/helpers/Providers/request_provider.dart';
import 'package:login/helpers/Providers/roomdetailsprovider.dart';
import 'package:login/helpers/Providers/roomimageprovider.dart';
import 'package:login/helpers/Providers/tabiconprovider.dart';
import 'package:login/helpers/Providers/transactionprovider.dart';
import 'package:login/helpers/slider/bottomdownsliderprovider.dart';
import 'package:login/helpers/slider/bottomupsliderprovider.dart';
import 'package:login/helpers/slider/leftsideslidericonprovider.dart';
import 'package:login/helpers/slider/link_provider.dart';
import 'package:login/helpers/slider/rightsidesliderprovider.dart';
import 'package:login/helpers/slider/topslidericonprovider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../citylist.dart';
import '../dashboard_method.dart';
import '../iconprovider.dart';

class ProviderList {
  static List<SingleChildWidget> providerList = [
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
    ChangeNotifierProvider.value(value: DashBoardMethods()),
    ChangeNotifierProvider.value(value: NotificationProvider()),
    ChangeNotifierProvider.value(value: RequestProvider()),
  ];
}
