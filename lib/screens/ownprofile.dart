import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/API/profileapi.dart';
import 'package:login/screens/editprofile.dart';
import 'package:login/screens/resetpassword.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class OwnProfile extends StatefulWidget {
  static const routeName = '/ownProfile';
  @override
  _OwnProfileState createState() => _OwnProfileState();
}

class _OwnProfileState extends State<OwnProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _isInit = true;
  var _name = '';
  var _youLink = '';
  var _linkedLink = '';
  var _dailyRate = '';
  var _profileImage = '';
  var _location = '';
  var _creditcard = '';
  var _occupation = '';
  var _companyName = '';
  var _aboutUs = '';
  var _workingHistory = '';
  List<dynamic> _links = [];

  bool _load = false;
  String _qrData = "Amit Butani";
  ProfileModal objProfileModal;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    imageCache.clear();
    imageCache.clearLiveImages();
    if (_isInit) {
      await tryToGetProfile();
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // final links = Provider.of<LinkProvider>(context).items;

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ResetPassword.roteName);
            },
            child: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(right: 0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,
                child: Image.asset('assets/icons/ResetPassword.png'),
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
                  radius: size.height > Constant.divSize ? 40 : 20,
                  child: Image.asset('assets/images/editicon.png')),
            ),
          ),
        ],
      ),
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
                      PageTitle(size: size, title: "Own Profile"),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: size.height > Constant.divSize
                            ? const EdgeInsets.symmetric(horizontal: 28.0)
                            : const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: size.height > Constant.divSize
                                  ? size.width / 2
                                  : size.width / 2 - 50,
                              height: size.height > Constant.divSize
                                  ? size.height - 150
                                  : size.height - 86,
                              // color: Colors.white,
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      key: ValueKey(new Random().nextInt(100)),
                                      radius: size.height > Constant.divSize
                                          ? 70
                                          : 30,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: _profileImage == ""
                                          ? AssetImage(
                                              'assets/images/profileimage.png')
                                          : NetworkImage(_profileImage),
                                    ),
                                    customSizedBox(size, 10),
                                    Text(
                                      _name,
                                      style: TextStyle(
                                        color: Constant.primaryColor,
                                        fontSize: size.height > Constant.divSize
                                            ? 35
                                            : 20,
                                      ),
                                    ),
                                    customSizedBox(size, 10),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: customTitleContent(
                                          size, "Company Name", _companyName),
                                    ),
                                    customSizedBox(size, 15),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: customTitleContent(
                                        size,
                                        "About Us",
                                        _aboutUs,
                                      ),
                                    ),
                                    customSizedBox(size, 15),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: customTitleContent(
                                        size,
                                        "Work History",
                                        _workingHistory,
                                      ),
                                    ),
                                    customSizedBox(size, 15),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: customTitleContent(
                                        size,
                                        "Email",
                                        _qrData,
                                      ),
                                    ),
                                    customSizedBox(size, 10),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Link',
                                        style: TextStyle(
                                          color: Constant.primaryColor,
                                          fontSize:
                                              size.height > Constant.divSize
                                                  ? 25
                                                  : 15,
                                        ),
                                      ),
                                    ),
                                    customSizedBox(size, 10),
                                    YouLink(
                                        size: size,
                                        heading: 'Youtube',
                                        link: _youLink,
                                        scaffoldKey: _scaffoldKey),
                                    customSizedBox(size, 10),
                                    YouLink(
                                        size: size,
                                        heading: 'LinkedIn',
                                        link: _linkedLink,
                                        scaffoldKey: _scaffoldKey),
                                    customSizedBox(size, 10),
                                    LimitedBox(
                                      maxHeight: 1000,
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(top: 0),
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _links.length,
                                        itemBuilder: (context, i) => YouLink(
                                          size: size,
                                          heading: _links[i]['title'],
                                          link: _links[i]['link'],
                                          scaffoldKey: _scaffoldKey,
                                        ),
                                      ),
                                    ),
                                    customSizedBox(size, 10),
                                    PointCredit(
                                      size: size,
                                      heading1: "Loyalty Point",
                                      value1: "70 Points",
                                      heading2: "Total Earned Amount",
                                      value2: "\$ 1000.00",
                                    ),
                                    customSizedBox(size, 20),
                                    PointCredit(
                                      size: size,
                                      heading1: "SUPREME Card",
                                      value1: "\$ 500.00",
                                      heading2: "Credit Card",
                                      value2: _creditcard,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
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
                                            locationOccupation(
                                                'Location',
                                                size,
                                                _location,
                                                true,
                                                Icons.location_on),
                                            customSizedBox(size, 10),
                                            locationOccupation(
                                                'Occuption',
                                                size,
                                                _occupation,
                                                false,
                                                Icons.ac_unit),
                                            customSizedBox(size, 10),
                                            locationOccupation(
                                                'Rate',
                                                size,
                                                _dailyRate,
                                                true,
                                                Icons.attach_money),
                                            customSizedBox(size, 10),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width < 721
                                            ? size.width / 2 - 180
                                            : 200,
                                        color: Constant.primaryColor,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: QrImage(
                                            size: size.width < 721
                                                ? size.width / 2 - 180
                                                : 200,
                                            data: _qrData,
                                          ),
                                        ),
                                      ),
                                      customSizedBox(size, 10),
                                      Container(
                                        width: size.width / 2 - 150,
                                        child: Divider(
                                          height: 3,
                                          thickness: 2,
                                          color: Constant.primaryColor,
                                        ),
                                      ),
                                      customSizedBox(size, 10),
                                      Container(
                                        height: size.height > Constant.divSize
                                            ? 100
                                            : 50,
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
                                      Container(
                                        width: size.width / 2 - 150,
                                        child: Divider(
                                          height: 3,
                                          thickness: 2,
                                          color: Constant.primaryColor,
                                        ),
                                      ),
                                      customSizedBox(size, 10),
                                      // customRatingBar(Icon(Icons.star),
                                      //     Icon(Icons.star_border)),
                                      RatingBar(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        // ignoreGestures: true,
                                        itemCount: 5,
                                        itemSize: 25,
                                        unratedColor: Colors.grey,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        itemBuilder: (context, _) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Image.asset(
                                              'assets/icons/selectStar.png'),
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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

  Column customTitleContent(Size size, String title, String content) {
    return Column(
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

  Future<void> tryToGetProfile() async {
    try {
      setState(() {
        _load = true;
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final _userEmail = sharedPreferences.getString('email');
      objProfileModal =
          await Provider.of<ProfileApi>(context, listen: false).getProfile();
      // print("In Profile Map" + objProfileModal.name);
      // print(map['profileimg']);
      setState(() {
        _name = objProfileModal.name;
        _location = objProfileModal.location;
        _linkedLink = objProfileModal.linkdin;
        _dailyRate = objProfileModal.dailycharge;
        _youLink = objProfileModal.youtube;
        _profileImage = objProfileModal.profileimg;
        _creditcard = objProfileModal.creditcard;
        _occupation = objProfileModal.occupation;
        _companyName = objProfileModal.companyname;
        _aboutUs = objProfileModal.aboutus;
        _workingHistory = objProfileModal.workinghistory;
        _links = objProfileModal.otherlink;
        _qrData = _userEmail;
      });
      print("_profileImage" + _profileImage);
      setState(() {
        _load = false;
      });
    } catch (error) {
      setState(() {
        _load = false;
      });
      print(error);
    }
  }
}

class CustomHeading extends StatelessWidget {
  const CustomHeading({
    Key key,
    @required this.size,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Constant.primaryColor,
        fontSize: size.height > Constant.divSize ? 25 : 15,
      ),
    );
  }
}

class PointCredit extends StatelessWidget {
  const PointCredit({
    Key key,
    @required this.size,
    @required this.heading1,
    @required this.value1,
    @required this.heading2,
    @required this.value2,
  }) : super(key: key);

  final Size size;
  final String heading1;
  final String value1;
  final String heading2;
  final String value2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              heading1,
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
              value1,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height > Constant.divSize
                    ? 20
                    : size.width < 600 ? 10 : 15,
              ),
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
              heading2,
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
              value2,
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
    );
  }
}

class YouLink extends StatelessWidget {
  const YouLink({
    Key key,
    @required this.size,
    @required this.heading,
    @required this.link,
    @required this.scaffoldKey,
  }) : super(key: key);

  final Size size;
  final String heading;
  final String link;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              heading,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height > Constant.divSize ? 23 : 10,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: size.width,
            height: size.height > Constant.divSize ? 80 : 40,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      link,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: size.height > Constant.divSize ? 23 : 10,
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: link));
                    scaffoldKey.currentState.hideCurrentSnackBar();
                    scaffoldKey.currentState.showSnackBar(new SnackBar(
                      content: new Text("Copied to Clipboard"),
                    ));
                  },
                  child: Text(
                    'Copy',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Constant.primaryColor,
                      fontSize: size.height > Constant.divSize ? 23 : 10,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
