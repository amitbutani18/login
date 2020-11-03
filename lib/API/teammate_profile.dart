import 'package:flutter/cupertino.dart';

class TeamMateProfile {
  String id;
  String name;
  String profileimg;
  String youtube;
  String linkdin;
  String location;
  // String creditcard;
  // String cardcvv;
  // String cardpin;
  // String cardexpirydate;
  String dailycharge;
  String occupation;
  // String serviceproviderid;
  String aboutus;
  String workinghistory;
  List<dynamic> otherlink;
  String companyname;

  TeamMateProfile({
    this.id,
    this.name,
    this.profileimg,
    this.youtube,
    this.linkdin,
    this.location,
    // this.creditcard,
    // this.cardcvv,
    // this.cardpin,
    // this.cardexpirydate,
    this.dailycharge,
    this.occupation,
    // this.serviceproviderid,
    this.aboutus,
    this.companyname,
    this.otherlink,
    this.workinghistory,
  });
}

class TeamMateProfileProvider with ChangeNotifier {
  TeamMateProfile _teamMateProfile = TeamMateProfile(
    id: "dasfd",
    name: "Amit",
    aboutus: "kgm vkfd f bkf bkf bkf bg ",
    companyname: "Amkfkf",
    dailycharge: "50",
    linkdin: "WWW.vxvmfd.vkfmk",
    location: "kdmgkdf",
    occupation: "d;fdgkfdmg",
  );

  TeamMateProfile get teamMateProfile {
    return _teamMateProfile;
  }
}
