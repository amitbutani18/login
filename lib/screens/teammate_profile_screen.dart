import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/API/profileapi.dart';
import 'package:login/helpers/Providers/membersprovider.dart';
import 'package:login/screens/contractdetails.dart';
import 'package:login/screens/editprofile.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

import 'ownprofile.dart';

class TeamMateProfileScreen extends StatefulWidget {
  static const routeName = '/TeamMateProfileScreen';
  final Member memberData;
  TeamMateProfileScreen({@required this.memberData});
  @override
  _TeamMateProfileScreenState createState() => _TeamMateProfileScreenState();
}

class _TeamMateProfileScreenState extends State<TeamMateProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _isInit = true;
  // var _name = '';
  // var _youLink = '';
  // var _linkedLink = '';
  // var _dailyRate = '';
  // var _profileImage = '';
  // var _location = '';
  // var _creditcard = '';
  // var _occupation = '';
  // var _companyName = '';
  // var _aboutUs = '';
  // var _workingHistory = '';
  // List<dynamic> _links = [];

  bool _load = false;
  String _qrData = "Amit Butani";
  ProfileModal objProfileModal;
  bool _isContain;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    imageCache.clear();
    imageCache.clearLiveImages();

    if (_isInit) {
      // await tryToGetProfile();
      final list =
          Provider.of<MembersProvider>(context, listen: false).selectedMembers;
      setState(() {
        _isContain = list.contains(widget.memberData);
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // final links = Provider.of<LinkProvider>(context).items;

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: customFloatingButton(context, size),
      body: Stack(
        children: <Widget>[
          PageBackground(
              size: size, imagePath: 'assets/images/profilebackground.png'),
          _load
              ? CustomCircularProgressIndicator()
              : Padding(
                  padding: size.height > Constant.divSize
                      ? const EdgeInsets.all(28.0)
                      : const EdgeInsets.only(top: 18, right: 18, left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PageTitle(size: size, title: "Team Mate Profile"),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: size.height > Constant.divSize
                            ? const EdgeInsets.symmetric(horizontal: 28.0)
                            : const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: <Widget>[
                            leftDetailsPart(size),
                            rightDetailsPart(size),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Row customFloatingButton(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _isContain
            ? Container()
            : GestureDetector(
                onTap: () {
                  Provider.of<MembersProvider>(context, listen: false)
                      .selectMember(widget.memberData);
                  setState(() {
                    _isContain = !_isContain;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.only(right: 0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 25,
                    child: Image.asset('assets/icons/contractDetail.png'),
                  ),
                ),
              ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => EditProfile(
                      objProfileModal: objProfileModal,
                      email: _qrData,
                    )));
          },
          child: Container(
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: size.height > Constant.divSize ? 40 : 25,
                child: Image.asset('assets/icons/message.png')),
          ),
        ),
      ],
    );
  }

  Expanded rightDetailsPart(Size size) {
    return Expanded(
      child: Container(
        width: size.height > Constant.divSize
            ? size.width / 2
            : size.width / 2 - 50,
        height: size.height > Constant.divSize
            ? size.height - 150
            : size.height - 100,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                width: size.width / 2 - 150,
                child: Column(
                  children: [
                    locationOccupation('Location', size,
                        widget.memberData.location, true, Icons.location_on),
                    customSizedBox(size, 10),
                    locationOccupation('Occuption', size,
                        widget.memberData.occupation, false, Icons.ac_unit),
                    customSizedBox(size, 10),
                    locationOccupation(
                        'Rate',
                        size,
                        widget.memberData.dailycharge,
                        true,
                        Icons.attach_money),
                    customSizedBox(size, 10),
                  ],
                ),
              ),
              Container(
                width: size.width < 721 ? size.width / 2 - 180 : 200,
                color: Constant.primaryColor,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: QrImage(
                    size: size.width < 721 ? size.width / 2 - 180 : 200,
                    data: widget.memberData.email,
                  ),
                ),
              ),
              customSizedBox(size, 10),
              CustomDivider(size: size),
              customSizedBox(size, 10),
              Container(
                height: size.height > Constant.divSize ? 100 : 50,
                width: size.height > Constant.divSize
                    ? size.width
                    : size.width / 2 - 150,
                // color:Constant.primaryColor,
                child: Image.asset(
                  'assets/images/Barcode.png',
                  fit: BoxFit.cover,
                ),
              ),
              customSizedBox(size, 10),
              // customRatingBar(Icon(Icons.star),
              //     Icon(Icons.star_border)),
            ],
          ),
        ),
      ),
    );
  }

  Container leftDetailsPart(Size size) {
    return Container(
      width:
          size.height > Constant.divSize ? size.width / 2 : size.width / 2 - 50,
      height:
          size.height > Constant.divSize ? size.height - 150 : size.height - 86,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              key: ValueKey(new Random().nextInt(100)),
              radius: size.height > Constant.divSize ? 70 : 30,
              backgroundColor: Colors.transparent,
              backgroundImage: widget.memberData.profileimg == ""
                  ? AssetImage('assets/images/profileimage.png')
                  : NetworkImage(
                      Constant.imageLink + widget.memberData.profileimg),
            ),
            customSizedBox(size, 10),
            Text(
              widget.memberData.name,
              style: TextStyle(
                color: Constant.primaryColor,
                fontSize: size.width < 600 ? 15 : 20,
              ),
            ),
            // customSizedBox(size, 10),
            // customTitleContent(
            //     size, "Company Name", widget.memberData.companyname),
            customSizedBox(size, 15),
            customTitleContent(
              size,
              "About Us",
              widget.memberData.aboutus,
            ),
            customSizedBox(size, 15),
            customTitleContent(
              size,
              "Work History",
              widget.memberData.workinghistory,
            ),
            customSizedBox(size, 15),
            customTitleContent(
              size,
              "Email",
              widget.memberData.email,
            ),
            customSizedBox(size, 10),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Link',
                style: TextStyle(
                  color: Constant.primaryColor,
                  fontSize: size.height > Constant.divSize ? 25 : 15,
                ),
              ),
            ),
            customSizedBox(size, 10),
            YouLink(
                size: size,
                heading: 'Youtube',
                link: widget.memberData.youtube,
                scaffoldKey: _scaffoldKey),
            customSizedBox(size, 10),
            YouLink(
                size: size,
                heading: 'LinkedIn',
                link: widget.memberData.linkdin,
                scaffoldKey: _scaffoldKey),
            customSizedBox(size, 10),
            LimitedBox(
              maxHeight: 1000,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.memberData.otherlink.length, //_links.length,
                itemBuilder: (context, i) => YouLink(
                  size: size,
                  heading: widget
                      .memberData.otherlink[i].title, //_links[i]['title'],
                  link:
                      widget.memberData.otherlink[i].link, // _links[i]['link'],
                  scaffoldKey: _scaffoldKey,
                ),
              ),
            ),
            customSizedBox(size, 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Rating",
                      style: TextStyle(
                        color: Constant.primaryColor,
                        fontSize: size.height > Constant.divSize
                            ? 25
                            : size.width < 600 ? 10 : 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RatingBar(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      // ignoreGestures: true,
                      itemCount: 5,
                      itemSize: size.width < 600 ? 20 : 25,
                      unratedColor: Colors.grey,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset('assets/icons/selectStar.png'),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: size.height > Constant.divSize ? 180 : 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Total Earbed Amount",
                      style: TextStyle(
                        color: Constant.primaryColor,
                        fontSize: size.height > Constant.divSize
                            ? 25
                            : size.width < 600 ? 10 : 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$ " + widget.memberData.dailycharge,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height > Constant.divSize
                            ? 20
                            : size.width < 600 ? 10 : 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            customSizedBox(size, 20),
            // PointCredit(
            //   size: size,
            //   heading1: "SUPREME Card",
            //   value1: "\$ 500.00",
            //   heading2: "Credit Card",
            //   value2: "_creditcard",
            // )
          ],
        ),
      ),
    );
  }

  Widget customTitleContent(Size size, String title, String content) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Constant.primaryColor,
              fontSize: size.height > Constant.divSize
                  ? 25
                  : size.width < 600 ? 10 : 15,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.height > Constant.divSize
                  ? 20
                  : size.width < 600 ? 10 : 15,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox customSizedBox(Size size, double sizeHeight) {
    return SizedBox(
      height: size.height > Constant.divSize ? 20 : sizeHeight,
    );
  }

  Widget locationOccupation(
    String lable,
    Size size,
    String _location,
    bool showIcon,
    IconData icon,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomHeading(size: size, title: lable),
        customSizedBox(size, 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            showIcon
                ? Icon(
                    icon,
                    size: size.height > Constant.divSize ? 20 : 10,
                    color: Colors.white,
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
            SizedBox(
              width: size.height > Constant.divSize ? 20 : 3,
            ),
            Text(
              _location,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height > Constant.divSize
                    ? 25
                    : size.width < 600 ? 8 : 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Future<void> tryToGetProfile() async {
  //   try {
  //     setState(() {
  //       _load = true;
  //     });
  //     SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     final _userEmail = sharedPreferences.getString('email');
  //     objProfileModal =
  //         await Provider.of<ProfileApi>(context, listen: false).getProfile();
  //     // print("In Profile Map" + objProfileModal.name);
  //     // print(map['profileimg']);
  //     setState(() {
  //       _name = objProfileModal.name;
  //       _location = objProfileModal.location;
  //       _linkedLink = objProfileModal.linkdin;
  //       _dailyRate = objProfileModal.dailycharge;
  //       _youLink = objProfileModal.youtube;
  //       _profileImage = objProfileModal.profileimg;
  //       _creditcard = objProfileModal.creditcard;
  //       _occupation = objProfileModal.occupation;
  //       _companyName = objProfileModal.companyname;
  //       _aboutUs = objProfileModal.aboutus;
  //       _workingHistory = objProfileModal.workinghistory;
  //       _links = objProfileModal.otherlink;
  //       _qrData = _userEmail;
  //     });
  //     print("_profileImage" + _profileImage);
  //     setState(() {
  //       _load = false;
  //     });
  //   } catch (error) {
  //     setState(() {
  //       _load = false;
  //     });
  //     print(error);
  //   }
  // }
}
