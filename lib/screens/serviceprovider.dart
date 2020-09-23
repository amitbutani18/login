import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login/API/serviceproviderapi.dart';
import 'package:login/helpers/roomimageprovider.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/dashbord_widgets/dashborddrawer.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/helpers/constant.dart' as Constant;

class ServiceProvider extends StatefulWidget {
  static const routeName = '/serviceProvider';
  @override
  _ServiceProviderState createState() => _ServiceProviderState();
}

class _ServiceProviderState extends State<ServiceProvider> {
  var diviceSize = 470;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _selfController;
  TextEditingController _websiteController;
  TextEditingController _whoController;
  TextEditingController _whereController;
  TextEditingController _vatNumberController;
  TextEditingController _regNumberController;
  TextEditingController _resPerNameController;
  TextEditingController _resPerMailController;
  TextEditingController _affiliatedController;
  TextEditingController _tagController;
  TextEditingController _addTeamMemberController;
  TextEditingController _membershipController;
  TextEditingController _addressController;
  TextEditingController _aboutUsController;
  TextEditingController _adverController;
  TextEditingController _billController;
  TextEditingController _discountController;
  TextEditingController _coupenController;

  bool _checked = true;

  File _logo, _fImage, _sImage, _tImage;
  final picker = ImagePicker();
  String _initLogo, _initImage1, _initImage2, _initImage3, serId;

  int _serviceproviderowner;
  bool _isEdit = false;
  bool _isInit = true;
  bool _isLoad = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    imageCache.clear();
    imageCache.clearLiveImages();
    if (_isInit) {
      setState(() {
        _isLoad = true;
      });
      final response =
          await Provider.of<ServiceProviderApi>(context, listen: false)
              .getServiceProvider();
      setState(() {
        _isLoad = false;
      });
      ServiceModel objServiceModal = response[1];
      print(objServiceModal.self);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        _serviceproviderowner =
            sharedPreferences.getInt("serviceproviderowner");
      });
      final _name = sharedPreferences.getString("name");
      print("serviceproviderowner" + _serviceproviderowner.toString());
      _selfController = TextEditingController(text: objServiceModal.self);
      _websiteController = TextEditingController(text: objServiceModal.website);
      _whoController = TextEditingController(text: _name);
      _whereController = TextEditingController(text: objServiceModal.where);
      _vatNumberController =
          TextEditingController(text: objServiceModal.vatnumber);
      _regNumberController =
          TextEditingController(text: objServiceModal.registrationnumber);
      _resPerNameController =
          TextEditingController(text: objServiceModal.respersonname);
      _resPerMailController =
          TextEditingController(text: objServiceModal.respersonemail);
      _affiliatedController =
          TextEditingController(text: objServiceModal.affiliatedprog);
      _tagController = TextEditingController(text: objServiceModal.tags);
      _addTeamMemberController =
          TextEditingController(text: objServiceModal.teamid);
      _membershipController =
          TextEditingController(text: objServiceModal.membership);
      _addressController = TextEditingController(text: objServiceModal.address);
      _aboutUsController = TextEditingController(text: objServiceModal.aboutus);
      _adverController = TextEditingController(text: objServiceModal.ads);
      _billController = TextEditingController(text: objServiceModal.billings);
      _discountController =
          TextEditingController(text: objServiceModal.discountdetails);
      _coupenController =
          TextEditingController(text: objServiceModal.couponcode);
      //Init Images
      print("LOOOOOOO");
      setState(() {
        _initLogo = objServiceModal.logo;
        _initImage1 = objServiceModal.image1;
        _initImage2 = objServiceModal.image2;
        _initImage3 = objServiceModal.image3;
      });

      serId = objServiceModal.id;
      _checked = objServiceModal.policystatus == "1" ? true : false;
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _selfController.dispose();
    _websiteController.dispose();
    _whoController.dispose();
    _whereController.dispose();
    _vatNumberController.dispose();
    _regNumberController.dispose();
    _resPerNameController.dispose();
    _resPerMailController.dispose();
    _affiliatedController.dispose();
    _tagController.dispose();
    _addTeamMemberController.dispose();
    _membershipController.dispose();
    _addressController.dispose();
    _aboutUsController.dispose();
    _adverController.dispose();
    _billController.dispose();
    _discountController.dispose();
    _coupenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<RoomImageProvider>(context).items;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          width: 70,
          color: Color.fromRGBO(49, 49, 49, 0.7),
          child: DashbordDrawer(),
        ),
      ),
      floatingActionButton: _serviceproviderowner == 1
          ? _isEdit
              ? Builder(
                  builder: (context) => acceptDeclineButton(size, context))
              : editButton(size)
          : Container(),
      body: Stack(
        children: <Widget>[
          PageBackground(
              size: size, imagePath: 'assets/images/profilebackground.png'),
          _isLoad
              ? CustomCircularProgressIndicator()
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(new FocusNode()),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          customAppBar(context),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: _isEdit
                                    ? () => _showMyDialog('logo')
                                    : null,
                                child: Container(
                                  // alignment: Alignment.center,
                                  width: size.width / 2 - 30,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Constant.primaryColor,
                                    ),
                                  ),
                                  child: _logo == null
                                      ? _initLogo == ''
                                          ? Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Add Logo",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Constant.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          : Image.network(
                                              _initLogo,
                                              fit: BoxFit.cover,
                                            )
                                      : Image.file(
                                          _logo,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                children: [
                                  _formField(
                                      'Self',
                                      size.width / 2 - 30,
                                      15,
                                      'assets/icons/Usericon.png',
                                      _selfController),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _formField(
                                      'Who',
                                      size.width / 2 - 30,
                                      15,
                                      'assets/icons/SelectedAdd-Team-Member.png',
                                      _whoController),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              _formField(
                                  'Website',
                                  size.width / 2 - 30,
                                  15,
                                  'assets/icons/Lickicon.png',
                                  _websiteController),
                              SizedBox(
                                width: 12,
                              ),
                              _formField('Where', size.width / 2 - 30, 15,
                                  'assets/icons/Where.png', _whereController),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              _formField(
                                  'VAT Number',
                                  size.width / 2 - 30,
                                  15,
                                  'assets/icons/Call.png',
                                  _vatNumberController),
                              SizedBox(
                                width: 12,
                              ),
                              _formField(
                                  'Registration Number',
                                  size.width / 2 - 30,
                                  15,
                                  'assets/icons/Call.png',
                                  _regNumberController),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              _formField(
                                  'Responsive Person Name',
                                  size.width / 2 - 30,
                                  15,
                                  'assets/icons/user.png',
                                  _resPerNameController),
                              SizedBox(
                                width: 12,
                              ),
                              _formField(
                                  'Responsive Person Email',
                                  size.width / 2 - 30,
                                  15,
                                  'assets/icons/mail.png',
                                  _resPerMailController),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                              'Afflicated Program',
                              size.width - 48,
                              15,
                              'assets/icons/Afflicated.png',
                              _affiliatedController),
                          SizedBox(
                            height: 20,
                          ),
                          _formField('Tags', size.width - 48, 15,
                              'assets/icons/Tags.png', _tagController),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                              'Add Team Member',
                              size.width - 48,
                              15,
                              'assets/icons/SelectedAdd-Team-Member.png',
                              _addTeamMemberController),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                              'Membership',
                              size.width - 48,
                              15,
                              'assets/icons/Subscription.png',
                              _membershipController),
                          SizedBox(
                            height: 20,
                          ),
                          _formField('Address', size.width - 48, 15,
                              'assets/icons/Where.png', _addressController),
                          SizedBox(
                            height: 20,
                          ),
                          _formField('About Us', size.width - 48, 15,
                              'assets/icons/About-Us.png', _aboutUsController),
                          SizedBox(
                            height: 20,
                          ),
                          _formField('Advertising', size.width - 48, 15,
                              'assets/icons/ad.png', _adverController),
                          SizedBox(
                            height: 20,
                          ),
                          _formField('Billing', size.width - 48, 15,
                              'assets/icons/Billing.png', _billController),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                              'Discount Details',
                              size.width - 48,
                              15,
                              'assets/icons/CouponCode.png',
                              _discountController),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: _isEdit
                                          ? () => _showMyDialog('fImage')
                                          : null,
                                      child: Container(
                                        height: size.height > diviceSize
                                            ? 300
                                            : 170,
                                        width: size.height > diviceSize
                                            ? 800
                                            : 160,
                                        child: _fImage == null
                                            ? _initImage1 == ''
                                                ? Image.asset(
                                                    'assets/images/uploadImage.png')
                                                : customNetworkImage(
                                                    _initImage1)
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.file(_fImage,
                                                    fit: BoxFit.cover)),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _isEdit
                                          ? () => _showMyDialog('sImage')
                                          : null,
                                      child: Container(
                                        height: size.height > diviceSize
                                            ? 300
                                            : 170,
                                        width: size.height > diviceSize
                                            ? 800
                                            : 160,
                                        child: _sImage == null
                                            ? _initImage2 == ''
                                                ? Image.asset(
                                                    'assets/images/uploadImage.png')
                                                : customNetworkImage(
                                                    _initImage2)
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.file(_sImage,
                                                    fit: BoxFit.cover)),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _isEdit
                                          ? () => _showMyDialog('tImage')
                                          : null,
                                      child: Container(
                                        height: size.height > diviceSize
                                            ? 300
                                            : 170,
                                        width: size.height > diviceSize
                                            ? 800
                                            : 160,
                                        child: _tImage == null
                                            ? _initImage3 == ''
                                                ? Image.asset(
                                                    'assets/images/uploadImage.png')
                                                : customNetworkImage(
                                                    _initImage3)
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.file(_tImage,
                                                    fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(left: 5, right: 15),
                                  child: _formField(
                                      'Coupen Code',
                                      0,
                                      15,
                                      'assets/icons/CouponCode.png',
                                      _coupenController),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          rememberMeBox(),
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget rememberMeBox() {
    return GestureDetector(
      onTap: _isEdit
          ? () {
              setState(() {
                _checked ? _checked = false : _checked = true;
              });
              print(_checked);
            }
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Constant.primaryColor),
                left: BorderSide(width: 1.0, color: Constant.primaryColor),
                right: BorderSide(width: 1.0, color: Constant.primaryColor),
                bottom: BorderSide(width: 1.0, color: Constant.primaryColor),
              ),
            ),
            child: Checkbox(
                activeColor: Colors.transparent,
                checkColor: Constant.primaryColor,
                value: _checked,
                onChanged: _isEdit
                    ? (value) {
                        setState(() {
                          _checked = value;
                        });
                      }
                    : null),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Agree To SUPREME Card Policy",
            style: TextStyle(color: Constant.primaryColor),
          ),
        ],
      ),
    );
  }

  ClipRRect customNetworkImage(String image) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(image, fit: BoxFit.cover));
  }

  GestureDetector editButton(Size size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isEdit = true;
        });
      },
      child: Container(
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: size.height > diviceSize ? 40 : 20,
            child: Image.asset('assets/images/editicon.png')),
      ),
    );
  }

  Row acceptDeclineButton(Size size, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (_checked) {
              _submit();
            } else {
              CustomSnackBar(context, "Please agree SUPREME card policy",
                  SnackBartype.nagetive);
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
          onTap: () {
            setState(() {
              _isEdit = false;
            });
            Navigator.of(context)
                .pushReplacementNamed(ServiceProvider.routeName);
          },
          child: Container(
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: size.height > diviceSize ? 40 : 30,
                child: Image.asset('assets/icons/Decline.png')),
          ),
        ),
      ],
    );
  }

  void _submit() async {
    String logoImage;
    String firstImage;
    String secImage;
    String thirdImage;
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (_logo != null) {
      var bytes = File(_logo.path).readAsBytesSync();
      logoImage = base64Encode(bytes);
    }
    if (_fImage != null) {
      final bytes = File(_fImage.path).readAsBytesSync();
      firstImage = base64Encode(bytes);
    }
    if (_sImage != null) {
      final bytes = File(_sImage.path).readAsBytesSync();
      secImage = base64Encode(bytes);
    }
    if (_tImage != null) {
      final bytes = File(_tImage.path).readAsBytesSync();
      thirdImage = base64Encode(bytes);
    }
    // setState(() {
    //   _isLoad = true;
    // });
    await Provider.of<ServiceProviderApi>(context, listen: false)
        .updateServiceProvider(
      id: serId,
      self: _selfController.text,
      where: _whereController.text,
      website: _websiteController.text,
      aboutus: _aboutUsController.text,
      address: _addressController.text,
      ads: _adverController.text,
      affiliatedprog: _affiliatedController.text,
      billings: _billController.text,
      couponcode: _coupenController.text,
      discountdetails: _discountController.text,
      membership: _membershipController.text,
      respersonname: _resPerNameController.text,
      respersonemail: _resPerMailController.text,
      tags: _tagController.text,
      teamid: _addTeamMemberController.text,
      registrationnumber: _regNumberController.text,
      vatnumber: _vatNumberController.text,
      image1: _fImage != null ? firstImage : '',
      image2: _sImage != null ? secImage : '',
      image3: _tImage != null ? thirdImage : '',
      logo: _logo != null ? logoImage : '',
      check: _checked,
    );
    // setState(() {
    //   _isLoad = false;
    // });
    _selfController.clear();
    _whereController.clear();
    _whoController.clear();
    _aboutUsController.clear();
    _affiliatedController.clear();
    _discountController.clear();
    _websiteController.clear();
    _websiteController.clear();
    _vatNumberController.clear();
    _regNumberController.clear();
    _resPerMailController.clear();
    _resPerNameController.clear();
    _tagController.clear();
    _addTeamMemberController.clear();
    _membershipController.clear();
    _addressController.clear();
    _adverController.clear();
    _billController.clear();
    _coupenController.clear();
    Navigator.of(context).pushReplacementNamed(ServiceProvider.routeName);
  }

  Row customAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/icons/Sidebar.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          child: Text(
            "Service Provider",
            style: TextStyle(
              color: Constant.primaryColor,
              fontSize: 22,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/icons/home.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
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
      child: TextField(
          controller: controller,
          enabled: _serviceproviderowner == 1
              ? _isEdit
                  ? lable == 'Who' || lable == 'Self' ? false : true
                  : false
              : false,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          style: TextStyle(color: Constant.primaryColor, fontSize: fontSize),
          decoration: CustomInputDecoration.customInputDecoration(
                  lable, fontSize, image)
              .copyWith(
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Constant.primaryColor)),
          )),
    );
  }

  Future<void> _showMyDialog(String lable) async {
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
                  onTap: () => getImageFromCam(lable),
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
                  onTap: () => getImageFromGal(lable),
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

  Future getImageFromCam(String lable) async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      if (lable == 'logo') {
        _logo = File(pickedFile.path);
      }
      if (lable == 'fImage') {
        _fImage = File(pickedFile.path);
      }
      if (lable == 'sImage') {
        _sImage = File(pickedFile.path);
      }
      if (lable == 'tImage') {
        _tImage = File(pickedFile.path);
      }
    });
  }

  Future getImageFromGal(String lable) async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      if (lable == 'logo') {
        _logo = File(pickedFile.path);
      }
      if (lable == 'fImage') {
        _fImage = File(pickedFile.path);
      }
      if (lable == 'sImage') {
        _sImage = File(pickedFile.path);
      }
      if (lable == 'tImage') {
        _tImage = File(pickedFile.path);
      }
    });
  }
}
