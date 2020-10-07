import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/API/profileapi.dart';
import 'package:login/screens/ownprofile.dart';
import 'package:login/widgets/cardmonthinputformatter.dart';
import 'package:login/widgets/cardnumberinputformateer.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customalertbox.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:provider/provider.dart';
import 'package:login/helpers/constant.dart' as Constant;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final ProfileModal objProfileModal;
  final String email;

  EditProfile({this.objProfileModal, this.email});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _fstNameController;
  TextEditingController _lastNameController;
  TextEditingController _companyNameController;
  TextEditingController _emailController;
  TextEditingController _aboutUSController;
  TextEditingController _workingHistoryController;
  TextEditingController _locationController;
  TextEditingController _creditController;
  TextEditingController _occuptionController;
  TextEditingController _cvvController;
  TextEditingController _pinController;
  TextEditingController _dailyChargeController;
  TextEditingController _dateChangeController;
  TextEditingController _youtubeController;
  TextEditingController _linkedinController;
  List<TextEditingController> titleController = [];
  List<TextEditingController> linkController = [];

  String _initialImage;

  File _image;
  final picker = ImagePicker();
  bool _isinit = true;
  bool _isLoad = false;
  List<dynamic> data = [], newList = [];
  int _length, _type = 0;

  var fieldCount;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isinit) {
      print("Initial Value");

      _fstNameController =
          TextEditingController(text: widget.objProfileModal.name);
      _lastNameController =
          TextEditingController(text: widget.objProfileModal.name);
      _companyNameController =
          TextEditingController(text: widget.objProfileModal.companyname);
      _locationController =
          TextEditingController(text: widget.objProfileModal.location);
      _creditController =
          TextEditingController(text: widget.objProfileModal.creditcard);
      _occuptionController =
          TextEditingController(text: widget.objProfileModal.occupation);
      _cvvController =
          TextEditingController(text: widget.objProfileModal.cardcvv);
      _pinController =
          TextEditingController(text: widget.objProfileModal.cardpin);
      _dailyChargeController =
          TextEditingController(text: widget.objProfileModal.dailycharge);
      _dateChangeController =
          TextEditingController(text: widget.objProfileModal.cardexpirydate);
      _emailController = TextEditingController(text: widget.email);
      _aboutUSController =
          TextEditingController(text: widget.objProfileModal.aboutus);
      _workingHistoryController =
          TextEditingController(text: widget.objProfileModal.workinghistory);
      _youtubeController =
          TextEditingController(text: widget.objProfileModal.youtube);
      _linkedinController =
          TextEditingController(text: widget.objProfileModal.linkdin);
      _initialImage = widget.objProfileModal.profileimg;
      // final listList = Provider.of<LinkProvider>(context, listen: false).items;
      data = widget.objProfileModal.otherlink;
      _length = data.length;
      fieldCount = data.length;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        _type = sharedPreferences.getInt("type");
      });
      print("_type" + _type.toString());
    }
    _isinit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _fstNameController.dispose();
    _lastNameController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    _aboutUSController.dispose();
    _workingHistoryController.dispose();
    _locationController.dispose();
    _creditController.dispose();
    _occuptionController.dispose();
    _cvvController.dispose();
    _pinController.dispose();
    _dailyChargeController.dispose();
    _dateChangeController.dispose();
    for (var i = 0; i < data.length; i++) {
      titleController[i].dispose();
      linkController[i].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // final links = Provider.of<LinkProvider>(context).items;
    // var lenght = links.length;

    List<Widget> children = _buildList();
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (validateField(context)) {
                  _submit();
                }
              },
              child: Container(
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: size.height > Constant.divSize ? 40 : 30,
                    child: Image.asset('assets/icons/Acept.png')),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(OwnProfile.routeName),
              child: Container(
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: size.height > Constant.divSize ? 40 : 30,
                    child: Image.asset('assets/icons/Decline.png')),
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Stack(
          children: <Widget>[
            PageBackground(
                size: size, imagePath: 'assets/images/profilebackground.png'),
            _isLoad
                ? CustomCircularProgressIndicator()
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: size.height > Constant.divSize
                          ? const EdgeInsets.all(28.0)
                          : const EdgeInsets.only(top: 18, right: 18, left: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              OwnProfile()));
                                },
                                child: Container(
                                    padding: EdgeInsets.only(top: 10),
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                        'assets/icons/backicon.png')),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                          color: Constant.primaryColor,
                                          fontSize:
                                              size.height > Constant.divSize
                                                  ? 40
                                                  : 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: size.height > Constant.divSize
                                ? const EdgeInsets.symmetric(horizontal: 28.0)
                                : const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => CustomAlertBox.shared
                                      .showMyDialog(
                                          context: context,
                                          getImageFromCam: getImageFromCam,
                                          getImageFromGal: getImageFromGal),
                                  child: Container(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            radius:
                                                size.height > Constant.divSize
                                                    ? 70
                                                    : 50,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: _image == null
                                                ? _initialImage == '' ||
                                                        _initialImage == null
                                                    ? AssetImage(
                                                        'assets/images/profileimage.png')
                                                    : NetworkImage(
                                                        _initialImage)
                                                : FileImage(_image),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 65.0, left: 72),
                                            child: CircleAvatar(
                                              radius: 15,
                                              child: Image.asset(
                                                  'assets/icons/addimgicon.png'),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 48.0),
                                  child: Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          // color: Colors.amber,
                                          image: DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: ExactAssetImage(
                                                  'assets/icons/Tag.png'))),
                                      child: _type == 1
                                          ? TagName(tagName: 'PROFILE')
                                          : TagName(tagName: 'COMPANY')),
                                ),
                                // SizedBox(height: 20),
                                _type == 1
                                    ? Row(
                                        children: [
                                          size.height > Constant.divSize
                                              ? _formField(
                                                  'Name',
                                                  size.width - 72,
                                                  30,
                                                  'assets/icons/Usericon.png',
                                                  TextInputType.text,
                                                  _fstNameController,
                                                )
                                              : _formField(
                                                  'Name',
                                                  size.width - 72,
                                                  15,
                                                  'assets/icons/Usericon.png',
                                                  TextInputType.text,
                                                  _fstNameController,
                                                ),
                                          // SizedBox(
                                          //   width: 12,
                                          // ),
                                          // size.height > Constant.divSize
                                          //     ? _formField(
                                          //         'Last Name',
                                          //         size.width / 2 - 42,
                                          //         30,
                                          //         'assets/icons/Usericon.png',
                                          //         _lastNameController)
                                          //     : _formField(
                                          //         'Last Name',
                                          //         size.width / 2 - 42,
                                          //         15,
                                          //         'assets/icons/Usericon.png',
                                          //         _lastNameController),
                                        ],
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    //Company Name
                                    size.height > Constant.divSize
                                        ? _formField(
                                            'Company Name',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Company.png',
                                            TextInputType.text,
                                            _companyNameController)
                                        : _formField(
                                            'Company Name',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Company.png',
                                            TextInputType.text,
                                            _companyNameController),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    //Location
                                    size.height > Constant.divSize
                                        ? _formField(
                                            'Location',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Locationicon.png',
                                            TextInputType.text,
                                            _locationController,
                                          )
                                        : _formField(
                                            'Location',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Locationicon.png',
                                            TextInputType.text,
                                            _locationController,
                                          ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    //Email
                                    size.height > Constant.divSize
                                        ? _formField(
                                            'Email',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/mail.png',
                                            TextInputType.emailAddress,
                                            _emailController)
                                        : _formField(
                                            'Email',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/mail.png',
                                            TextInputType.emailAddress,
                                            _emailController),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    //Occupation
                                    size.height > Constant.divSize
                                        ? _formField(
                                            'Occuption',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Profession.png',
                                            TextInputType.text,
                                            _occuptionController)
                                        : _formField(
                                            'Occuption',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Profession.png',
                                            TextInputType.text,
                                            _occuptionController),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //About Us
                                _formFieldForAbout(
                                    'About Us',
                                    size.width - 42,
                                    15,
                                    'assets/icons/About-Us.png',
                                    _aboutUSController),
                                SizedBox(
                                  height: 20,
                                ),
                                //Working History
                                _formFieldForAbout(
                                    'Working History',
                                    size.width - 42,
                                    15,
                                    'assets/icons/Work_History.png',
                                    _workingHistoryController),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Links",
                                      style: TextStyle(
                                          color: Constant.primaryColor,
                                          fontSize:
                                              size.height > Constant.divSize
                                                  ? 20
                                                  : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          fieldCount++;
                                          // data.add({
                                          //   'id': DateTime.now().toString(),
                                          //   'title': '',
                                          //   'link': '',
                                          //   'init': false,
                                          // });
                                        });
                                        print(data.length);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.only(right: 0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 15,
                                          child: Image.asset(
                                              'assets/icons/AddLink.png'),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  width: size.width,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      YouLinks(
                                          size: size,
                                          controller: _youtubeController,
                                          hintText: 'Youtube'),
                                      YouLinks(
                                          size: size,
                                          controller: _linkedinController,
                                          hintText: 'Linkedin')
                                    ],
                                  ),
                                ),
                                LimitedBox(
                                  maxHeight: 1000,
                                  child: GridView(
                                    padding: EdgeInsets.only(top: 0),
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            // maxCrossAxisExtent: 200,
                                            childAspectRatio: size.width < 700
                                                ? 0.60 / 0.17
                                                : 0.90 / 0.17,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 0,
                                            crossAxisCount: 2),
                                    children: children,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Credit Card Details",
                                      style: TextStyle(
                                          color: Constant.primaryColor,
                                          fontSize:
                                              size.height > Constant.divSize
                                                  ? 20
                                                  : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    size.height > Constant.divSize
                                        ? _formField(
                                            'Credit card number',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Credit-Card.png',
                                            TextInputType.number,
                                            _creditController)
                                        : _formField(
                                            'Credit card number',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Credit-Card.png',
                                            TextInputType.number,
                                            _creditController),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    size.height > Constant.divSize
                                        ? _formField(
                                            'CVV',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/cvv.png',
                                            TextInputType.number,
                                            _cvvController,
                                          )
                                        : _formField(
                                            'CVV',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/cvv.png',
                                            TextInputType.number,
                                            _cvvController,
                                          ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    size.height > Constant.divSize
                                        ? _formField(
                                            'Pin',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/password.png',
                                            TextInputType.number,
                                            _pinController)
                                        : _formField(
                                            'Pin',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/password.png',
                                            TextInputType.number,
                                            _pinController),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    expiryDateField(size),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Daily Charge",
                                      style: TextStyle(
                                          color: Constant.primaryColor,
                                          fontSize:
                                              size.height > Constant.divSize
                                                  ? 20
                                                  : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    size.height > Constant.divSize
                                        ? _formField(
                                            'Daily Charge',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Dollar.png',
                                            TextInputType.number,
                                            _dailyChargeController,
                                          )
                                        : _formField(
                                            'Daily Charge',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Dollar.png',
                                            TextInputType.number,
                                            _dailyChargeController,
                                          ),
                                  ],
                                ),
                                SizedBox(height: 80),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // Container youLink(
  //     {Size size, String hintText, TextEditingController controller}) {
  //   return
  // }

  Container expiryDateField(Size size) {
    return Container(
      width: size.width / 2 - 42,
      child: TextFormField(
        controller: _dateChangeController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          new LengthLimitingTextInputFormatter(4),
          CardMonthInputFormatter()
        ],
        style: TextStyle(color: Constant.primaryColor, fontSize: 15),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 15,
          ),
          hintText: "MM / YY",
          hintStyle: TextStyle(color: Constant.primaryColor, fontSize: 15),
          prefixIcon: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 10,
              child: Image.asset("assets/icons/Expiration-Date.png"),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Constant.primaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Constant.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _formField(
    String lable,
    double width,
    double fontSize,
    String image,
    TextInputType textInputType,
    TextEditingController controller,
  ) {
    return Container(
      width: width,
      child: TextFormField(
          inputFormatters: lable == 'Credit card number'
              ? [
                  WhitelistingTextInputFormatter.digitsOnly,
                  new LengthLimitingTextInputFormatter(16),
                  CardNumberInputFormatter()
                ]
              : [],
          enabled: lable == 'Email' || lable == 'Company Name' ? false : true,
          obscureText: lable == 'CVV' || lable == 'Pin' ? true : false,
          keyboardType: textInputType,
          maxLines: 1,
          controller: controller,
          style: TextStyle(color: Constant.primaryColor, fontSize: fontSize),
          decoration: CustomInputDecoration.customInputDecoration(
                  lable, fontSize, image)
              .copyWith(
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Constant.primaryColor)))),
    );
  }

  List<Widget> _buildList() {
    for (var i = 0; i < _length; i++) {
      if (data[i]['init'] == false) {
        titleController.add(TextEditingController(text: data[i]['title']));
        linkController.add(TextEditingController(text: data[i]['link']));
        data[i]['init'] = true;
      }
    }

    if (titleController.length < fieldCount) {
      for (var i = titleController.length; i < fieldCount; i++) {
        titleController.add(TextEditingController());
        linkController.add(TextEditingController());
      }
    }
    List<Widget> list = [];
    for (var i = 0; i < titleController.length; i++) {
      list.add(Column(
        key: Key("$i"),
        children: [
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: 'New Link',
              hintStyle: TextStyle(color: Constant.primaryColor, fontSize: 10),
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(8), // Added this
            ),
            style: TextStyle(color: Constant.primaryColor, fontSize: 10),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: titleController[i],
                  style: TextStyle(color: Colors.white54, fontSize: 15),
                  decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.white54),
                      fillColor: Colors.grey[850],
                      contentPadding: EdgeInsets.all(10)),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: linkController[i],
                  style: TextStyle(color: Colors.white54, fontSize: 15),
                  decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Enter Link",
                      hintStyle: TextStyle(color: Colors.white54),
                      fillColor: Colors.grey[850],
                      contentPadding: EdgeInsets.all(10)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                key: Key("$i"),
                onTap: () {
                  setState(() {
                    fieldCount--;
                    titleController.remove(titleController[i]);
                    linkController.remove(linkController[i]);
                  });
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ));
    }
    return list;
  }

  Widget _formFieldForAbout(
    String lable,
    double width,
    double fontSize,
    String image,
    TextEditingController controller,
  ) {
    return Container(
      width: width,
      child: TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: controller,
          style: TextStyle(color: Constant.primaryColor, fontSize: fontSize),
          decoration: CustomInputDecoration.customInputDecoration(
              lable, fontSize, image)),
    );
  }

  Future getImageFromCam() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 10,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromGal() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 10,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  bool validateField(BuildContext context) {
    if (_type == 1) {
      if (_fstNameController.text.isEmpty) {
        CustomSnackBar(context, Constant.userNameMsg, SnackBartype.nagetive);
        return false;
      }
    }
    for (var i = 0; i < titleController.length; i++) {
      if (titleController[i].text == '') {
        CustomSnackBar(context, Constant.titleMsg, SnackBartype.nagetive);
        return false;
      }
      if (linkController[i].text == '') {
        CustomSnackBar(context, Constant.linkMsg, SnackBartype.nagetive);
        return false;
      }
    }
    return true;
  }

  void _submit() async {
    // print("fieldCount");
    for (var i = 0; i < titleController.length; i++) {
      // print("Title $i " + titleController[i].text);
      // print("Link $i " + linkController[i].text);
      newList.add(
        {
          'title': titleController[i].text,
          'link': linkController[i].text,
          'init': false
        },
      );
    }
    // print(newList);
    // print("newList " + newList.length.toString());
    FocusScopeNode currentFocus = FocusScope.of(context);
    String image;
    if (_image != null) {
      var bytes = File(_image.path).readAsBytesSync();
      image = base64Encode(bytes);
      print(image);
    }
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    try {
      setState(() {
        _isLoad = true;
      });
      await Provider.of<ProfileApi>(context, listen: false).updatePro(
        name: _fstNameController.text.trim(),
        location: _locationController.text.trim(),
        creditcard: _creditController.text.trim(),
        occupation: _occuptionController.text.trim(),
        cvv: _cvvController.text.trim(),
        pin: _pinController.text.trim(),
        date: _dateChangeController.text.trim(),
        dailyCharge: _dailyChargeController.text.trim(),
        aboutUs: _aboutUSController.text.trim(),
        lkdinLink: _linkedinController.text.trim(),
        ytLink: _youtubeController.text.trim(),
        otherLink: newList,
        workingHistory: _workingHistoryController.text.trim(),
        image: _image == null ? '' : image,
      );
      setState(() {
        _isLoad = false;
      });
      Navigator.of(context).pushReplacementNamed(OwnProfile.routeName);
    } catch (e) {
      print("Error" + e);
      setState(() {
        _isLoad = false;
      });
    }
  }
}

class YouLinks extends StatelessWidget {
  final Size size;
  String hintText;
  TextEditingController controller;
  YouLinks({this.size, this.hintText, this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 2 - 42,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: hintText,
              hintStyle: TextStyle(color: Constant.primaryColor, fontSize: 10),
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(8), // Added this
            ),
            style: TextStyle(color: Constant.primaryColor, fontSize: 10),
          ),
          TextField(
            controller: controller,
            style: TextStyle(color: Colors.white54, fontSize: 15),
            decoration: InputDecoration(
                filled: true,
                isDense: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: "Enter Link",
                hintStyle: TextStyle(color: Colors.white54),
                fillColor: Colors.grey[850],
                contentPadding: EdgeInsets.all(10)),
          ),
        ],
      ),
    );
  }
}

class TagName extends StatelessWidget {
  final String tagName;
  const TagName({
    this.tagName,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
          tagName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
