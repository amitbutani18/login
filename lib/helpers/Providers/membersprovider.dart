import 'package:flutter/foundation.dart';

class Member {
  String id;
  String name;
  String profileimg;
  String youtube;
  String linkdin;
  String location;
  double amount;
  String email;
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

  Member({
    this.id,
    this.name,
    this.profileimg,
    this.youtube,
    this.linkdin,
    this.location,
    this.amount,
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
    this.email,
    this.workinghistory,
  });
}

class MembersProvider with ChangeNotifier {
  List<Member> _items = [
    Member(
      id: "dasfd",
      name: "Amit",
      profileimg:
          'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
      aboutus: "kgm vkfd f bkf bkf bkf bg ",
      companyname: "Amkfkf",
      dailycharge: "50",
      amount: 25.0,
      youtube: "www.youtube.com",
      email: 'amit.butani29@hmail,cins',
      linkdin: "WWW.vxvmfd.vkfmk",
      location: "kdmgkdf",
      otherlink: [
        {
          'title': 'Github',
          'link': 'www.github.com',
        },
        {
          'title': 'Test',
          'link': 'www.test.com',
        },
      ],
      workinghistory: "Asfj jfd fd dfjg jd jg dg ds gksdg k fds",
      occupation: "d;fdgkfdmg",
    ),
    Member(
      id: "dasfd",
      amount: 25.0,
      name: "Amit Butabni",
      aboutus: "kgm vkfd f bkf bkf bkf bg ",
      companyname: "Amkfkf",
      dailycharge: "50",
      linkdin: "WWW.vxvmfd.vkfmk",
      location: "kdmgkdf",
      occupation: "d;fdgkfdmg",
    ),
    Member(
      id: "dasfd",
      name: "Hello World",
      aboutus: "kgm vkfd f bkf bkf bkf bg ",
      companyname: "Amkfkf",
      dailycharge: "50",
      linkdin: "WWW.vxvmfd.vkfmk",
      location: "kdmgkdf",
      amount: 25.0,
      occupation: "d;fdgkfdmg",
    ),
    Member(
      id: "dasfd",
      name: "Akash Gajera",
      aboutus: "kgm vkfd f bkf bkf bkf bg ",
      companyname: "Amkfkf",
      dailycharge: "50",
      linkdin: "WWW.vxvmfd.vkfmk",
      amount: 25.0,
      location: "kdmgkdf",
      occupation: "d;fdgkfdmg",
    ),
    Member(
      id: "dasfd",
      name: "Amit",
      aboutus: "kgm vkfd f bkf bkf bkf bg ",
      companyname: "Amkfkf",
      dailycharge: "50",
      linkdin: "WWW.vxvmfd.vkfmk",
      location: "kdmgkdf",
      occupation: "d;fdgkfdmg",
      amount: 25.0,
    ),
    Member(
      id: "dasfd",
      name: "Amit",
      aboutus: "kgm vkfd f bkf bkf bkf bg ",
      companyname: "Amkfkf",
      dailycharge: "50",
      linkdin: "WWW.vxvmfd.vkfmk",
      amount: 25.0,
      location: "kdmgkdf",
      occupation: "d;fdgkfdmg",
    ),
  ];

  List<Member> get items {
    return [..._items];
  }
}
