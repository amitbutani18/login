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
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final ProfileModal objProfileModal;

  EditProfile({this.objProfileModal});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var diviceSize = 470;

  TextEditingController _nameController;
  TextEditingController _ytLinkController;
  TextEditingController _linkedinController;
  TextEditingController _locationController;
  TextEditingController _creditController;
  TextEditingController _occuptionController;
  TextEditingController _cvvController;
  TextEditingController _pinController;
  TextEditingController _dailyChargeController;
  TextEditingController _dateChangeController;

  String _initialImage;

  File _image;
  final picker = ImagePicker();
  bool _isinit = true;
  bool _isLoad = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isinit) {
      print("Initial Value");
      _nameController =
          TextEditingController(text: widget.objProfileModal.name);
      _ytLinkController =
          TextEditingController(text: widget.objProfileModal.youtube);
      _linkedinController =
          TextEditingController(text: widget.objProfileModal.linkdin);
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
      _initialImage = widget.objProfileModal.profileimg;
    }
    _isinit = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                    radius: size.height > diviceSize ? 40 : 30,
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
                    radius: size.height > diviceSize ? 40 : 30,
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
                      padding: size.height > diviceSize
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
                                          color: Colors.amber[300],
                                          fontSize: size.height > diviceSize
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
                            padding: size.height > diviceSize
                                ? const EdgeInsets.symmetric(horizontal: 28.0)
                                : const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: _showMyDialog,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: size.height > diviceSize
                                                ? 70
                                                : 50,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: _image == null
                                                ? _initialImage == ''
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
                                Row(
                                  children: [
                                    size.height > diviceSize
                                        ? _formField(
                                            'Name',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Usericon.png',
                                            _nameController,
                                          )
                                        : _formField(
                                            'Name',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Usericon.png',
                                            _nameController,
                                          ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    size.height > diviceSize
                                        ? _formField(
                                            'Youtube Link(optional)',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Lickicon.png',
                                            _ytLinkController)
                                        : _formField(
                                            'Youtube Link(optional)',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Lickicon.png',
                                            _ytLinkController),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    size.height > diviceSize
                                        ? _formField(
                                            'Linkedin(optional)',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Lickicon.png',
                                            _linkedinController)
                                        : _formField(
                                            'Linkedin(optional)',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Lickicon.png',
                                            _linkedinController),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    size.height > diviceSize
                                        ? _formField(
                                            'Location',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Locationicon.png',
                                            _locationController,
                                          )
                                        : _formField(
                                            'Location',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Locationicon.png',
                                            _locationController,
                                          ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    size.height > diviceSize
                                        ? _formField(
                                            'Occuption',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Lickicon.png',
                                            _occuptionController)
                                        : _formField(
                                            'Occuption',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Lickicon.png',
                                            _occuptionController),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Credit Card Details",
                                      style: TextStyle(
                                          color: Colors.amber[300],
                                          fontSize: size.height > diviceSize
                                              ? 20
                                              : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    size.height > diviceSize
                                        ? _formField(
                                            'Credit card number',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Lickicon.png',
                                            _creditController)
                                        : _formField(
                                            'Credit card number',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Lickicon.png',
                                            _creditController),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    size.height > diviceSize
                                        ? _formField(
                                            'CVV',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/password.png',
                                            _cvvController,
                                          )
                                        : _formField(
                                            'CVV',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/password.png',
                                            _cvvController,
                                          ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    size.height > diviceSize
                                        ? _formField(
                                            'Pin',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/password.png',
                                            _pinController)
                                        : _formField(
                                            'Pin',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/password.png',
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
                                          color: Colors.amber[300],
                                          fontSize: size.height > diviceSize
                                              ? 20
                                              : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    size.height > diviceSize
                                        ? _formField(
                                            'Daily Charge',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/calender.png',
                                            _dailyChargeController,
                                          )
                                        : _formField(
                                            'Daily Charge',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/calender.png',
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
        style: TextStyle(color: Colors.yellow[300], fontSize: 15),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 15,
          ),
          hintText: "MM / YY",
          hintStyle: TextStyle(color: Colors.amber[300], fontSize: 15),
          prefixIcon: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 10,
              child: Image.asset("assets/icons/password.png"),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
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
          obscureText: lable == 'CVV' || lable == 'Pin' ? true : false,
          keyboardType: lable == 'Credit card number' ||
                  lable == 'CVV' ||
                  lable == 'Pin' ||
                  lable == 'Daily Charge'
              ? TextInputType.number
              : TextInputType.text,
          controller: controller,
          style: TextStyle(color: Colors.yellow[300], fontSize: fontSize),
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
    if (_nameController.text.isEmpty) {
      CustomSnackBar(
          context, 'Username must be not empty', SnackBartype.nagetive);
      return false;
    } else {
      return true;
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Pick Photo",
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: Color.fromRGBO(37, 36, 41, 1),
          content: Container(
            height: 100,
            width: 200,
            child: Column(
              children: [
                GestureDetector(
                  onTap: getImageFromCam,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Text(
                      "Camera",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white24,
                ),
                GestureDetector(
                  onTap: getImageFromGal,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      "Gallery",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submit() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    try {
      setState(() {
        _isLoad = true;
      });
      _image == null
          ? await Provider.of<ProfileApi>(context, listen: false).updatePro(
              _nameController.text.trim(),
              _ytLinkController.text.trim(),
              _linkedinController.text.trim(),
              _locationController.text.trim(),
              _creditController.text.trim(),
              _occuptionController.text.trim(),
              _cvvController.text.trim(),
              _pinController.text.trim(),
              _dateChangeController.text.trim(),
              _dailyChargeController.text.trim(),
            )
          : await Provider.of<ProfileApi>(context, listen: false)
              .updateProWithimg(
              _nameController.text.trim(),
              _ytLinkController.text.trim(),
              _linkedinController.text.trim(),
              _locationController.text.trim(),
              _image,
              _creditController.text.trim(),
              _occuptionController.text.trim(),
              _cvvController.text.trim(),
              _pinController.text.trim(),
              _dateChangeController.text.trim(),
              _dailyChargeController.text.trim(),
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

    print("_name" + _nameController.text);
    print("_ytLink" + _ytLinkController.text);
    print("_linkedinLink" + _linkedinController.text);
    print("_location" + _locationController.text);
    print("_creditcard" + _creditController.text);
    print("_cvv" + _cvvController.text);
    print("_pin" + _pinController.text);
    print("_dailyCharge" + _dailyChargeController.text);
    print(_image);
  }
}
