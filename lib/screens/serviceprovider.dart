import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/API/serviceproviderapi.dart';
import 'package:login/helpers/roomimageprovider.dart';
import 'package:login/widgets/Page_titles/pg_title_wth_drawr.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customalertbox.dart';
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
      _initLogo = objServiceModal.logo;
      _initImage1 = objServiceModal.image1;
      _initImage2 = objServiceModal.image2;
      _initImage3 = objServiceModal.image3;

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
                          PageTitleWithDrawer(
                            scaffoldKey: _scaffoldKey,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: _isEdit
                                    ? () => CustomAlertBox.shared.showMyDialog(
                                        context: context,
                                        getImageFromCam: () =>
                                            getImageFromCam('logo'),
                                        getImageFromGal: () =>
                                            getImageFromGal('logo'))
                                    : null,
                                child: Container(
                                  // alignment: Alignment.center,
                                  width: size.width / 2 - 30,
                                  height: 220,
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
                                              fit: BoxFit.contain,
                                            )
                                      : Image.file(
                                          _logo,
                                          fit: BoxFit.contain,
                                        ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                children: [
                                  _formField(
                                    lable: 'Self',
                                    width: size.width / 2 - 30,
                                    fontSize: 15,
                                    image: 'assets/icons/Usericon.png',
                                    textInputType: TextInputType.text,
                                    controller: _selfController,
                                    maxLine: 1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _formField(
                                    lable: 'Who',
                                    width: size.width / 2 - 30,
                                    fontSize: 15,
                                    image:
                                        'assets/icons/SelectedAdd-Team-Member.png',
                                    textInputType: TextInputType.text,
                                    controller: _whoController,
                                    maxLine: 1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _formField(
                                    lable: 'Website',
                                    width: size.width / 2 - 30,
                                    fontSize: 15,
                                    image: 'assets/icons/Lickicon.png',
                                    textInputType: TextInputType.url,
                                    controller: _websiteController,
                                    maxLine: 1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _formField(
                                    lable: 'Where',
                                    width: size.width / 2 - 30,
                                    fontSize: 15,
                                    image: 'assets/icons/Where.png',
                                    textInputType: TextInputType.text,
                                    controller: _whereController,
                                    maxLine: 1,
                                  ),
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
                                lable: 'VAT Number',
                                width: size.width / 2 - 30,
                                fontSize: 15,
                                image: 'assets/icons/Call.png',
                                textInputType: TextInputType.text,
                                controller: _vatNumberController,
                                maxLine: 1,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              _formField(
                                lable: 'Registration Number',
                                width: size.width / 2 - 30,
                                fontSize: 15,
                                image: 'assets/icons/Call.png',
                                textInputType: TextInputType.text,
                                controller: _regNumberController,
                                maxLine: 1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              _formField(
                                lable: 'Responsive Person Name',
                                width: size.width / 2 - 30,
                                fontSize: 15,
                                image: 'assets/icons/user.png',
                                textInputType: TextInputType.text,
                                controller: _resPerNameController,
                                maxLine: 1,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              _formField(
                                lable: 'Responsive Person Email',
                                width: size.width / 2 - 30,
                                fontSize: 15,
                                image: 'assets/icons/mail.png',
                                textInputType: TextInputType.emailAddress,
                                controller: _resPerMailController,
                                maxLine: 1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Afflicated Program',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/Afflicated.png',
                            textInputType: TextInputType.text,
                            controller: _affiliatedController,
                            maxLine: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Tags',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/Tags.png',
                            textInputType: TextInputType.text,
                            controller: _tagController,
                            maxLine: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Add Team Member',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/SelectedAdd-Team-Member.png',
                            textInputType: TextInputType.text,
                            controller: _addTeamMemberController,
                            maxLine: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Membership',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/Subscription.png',
                            textInputType: TextInputType.text,
                            controller: _membershipController,
                            maxLine: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Address',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/Where.png',
                            textInputType: TextInputType.text,
                            controller: _addressController,
                            maxLine: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'About Us',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/About-Us.png',
                            textInputType: TextInputType.multiline,
                            controller: _aboutUsController,
                            maxLine: null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Advertising',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/ad.png',
                            textInputType: TextInputType.multiline,
                            controller: _adverController,
                            maxLine: null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Billing',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/Billing.png',
                            textInputType: TextInputType.multiline,
                            controller: _billController,
                            maxLine: null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Discount Details',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/CouponCode.png',
                            textInputType: TextInputType.multiline,
                            controller: _discountController,
                            maxLine: null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: _isEdit
                                            ? () => CustomAlertBox.shared
                                                .showMyDialog(
                                                    context: context,
                                                    getImageFromCam: () =>
                                                        getImageFromCam(
                                                            'fImage'),
                                                    getImageFromGal: () =>
                                                        getImageFromGal(
                                                            'fImage'))
                                            : null,
                                        child: Container(
                                          height: size.height > Constant.divSize
                                              ? 300
                                              : 170,
                                          width: size.height > Constant.divSize
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
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: _isEdit
                                            ? () => CustomAlertBox.shared
                                                .showMyDialog(
                                                    context: context,
                                                    getImageFromCam: () =>
                                                        getImageFromCam(
                                                            'sImage'),
                                                    getImageFromGal: () =>
                                                        getImageFromGal(
                                                            'sImage'))
                                            : null,
                                        child: Container(
                                          height: size.height > Constant.divSize
                                              ? 300
                                              : 170,
                                          width: size.height > Constant.divSize
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
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: _isEdit
                                            ? () => CustomAlertBox.shared
                                                .showMyDialog(
                                                    context: context,
                                                    getImageFromCam: () =>
                                                        getImageFromCam(
                                                            'tImage'),
                                                    getImageFromGal: () =>
                                                        getImageFromGal(
                                                            'tImage'))
                                            : null,
                                        child: Container(
                                          height: size.height > Constant.divSize
                                              ? 300
                                              : 170,
                                          width: size.height > Constant.divSize
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
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 15),
                                      child: _formField(
                                        lable: 'Coupen Code',
                                        width: size.width,
                                        fontSize: 15,
                                        image: 'assets/icons/CouponCode.png',
                                        textInputType: TextInputType.text,
                                        controller: _coupenController,
                                        maxLine: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RatingBar(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      ignoreGestures: true,
                                      itemCount: 5,
                                      itemSize: 25,
                                      unratedColor: Colors.grey,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 0.0),
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
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          agreementBoxCheckBox(),
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget agreementBoxCheckBox() {
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
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Constant.primaryColor,
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
            radius: size.height > Constant.divSize ? 40 : 20,
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
                radius: size.height > Constant.divSize ? 40 : 30,
                child: Image.asset('assets/icons/Acept.png')),
          ),
        ),
        SizedBox(
          width: 15,
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
                radius: size.height > Constant.divSize ? 40 : 30,
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
    setState(() {
      _isLoad = true;
    });
    await Provider.of<ServiceProviderApi>(context, listen: false)
        .updateServiceProvider(
      id: serId,
      self: _selfController.text.trim(),
      where: _whereController.text.trim(),
      website: _websiteController.text.trim(),
      aboutus: _aboutUsController.text.trim(),
      address: _addressController.text.trim(),
      ads: _adverController.text.trim(),
      affiliatedprog: _affiliatedController.text.trim(),
      billings: _billController.text.trim(),
      couponcode: _coupenController.text.trim(),
      discountdetails: _discountController.text.trim(),
      membership: _membershipController.text.trim(),
      respersonname: _resPerNameController.text.trim(),
      respersonemail: _resPerMailController.text.trim(),
      tags: _tagController.text.trim(),
      teamid: _addTeamMemberController.text.trim(),
      registrationnumber: _regNumberController.text.trim(),
      vatnumber: _vatNumberController.text.trim(),
      image1: _fImage != null ? firstImage : '',
      image2: _sImage != null ? secImage : '',
      image3: _tImage != null ? thirdImage : '',
      logo: _logo != null ? logoImage : '',
      check: _checked,
    );
    setState(() {
      _isLoad = false;
    });
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

  Widget _formField({
    String lable,
    double width,
    double fontSize,
    String image,
    TextInputType textInputType,
    TextEditingController controller,
    int maxLine,
  }) {
    return Container(
      width: width,
      child: TextField(
          controller: controller,
          enabled: _serviceproviderowner == 1
              ? _isEdit
                  ? lable == 'Who' || lable == 'Self' ? false : true
                  : false
              : false,
          keyboardType: textInputType,
          maxLines: maxLine,
          textInputAction: TextInputAction.done,
          // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          style: TextStyle(color: Constant.primaryColor, fontSize: fontSize),
          decoration: CustomInputDecoration.customInputDecoration(
                  lable, fontSize, image)
              .copyWith(
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Constant.primaryColor)),
          )),
    );
  }

  Future getImageFromCam(String lable) async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        // imageQuality: 80,
        maxHeight: 200,
        maxWidth: 1000);
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
        // imageQuality: 70,
        maxHeight: 250,
        maxWidth: 1000);
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
