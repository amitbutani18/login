import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/API/profileapi.dart';
import 'package:login/screens/ownprofile.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var diviceSize = 470;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController;
  TextEditingController _ytLinkController;
  TextEditingController _linkedinController;
  TextEditingController _locationController;

  String _name;
  String _ytLink;
  String _linkedinLink;
  String _location;
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
      setState(() {
        _isLoad = true;
      });
      final map =
          await Provider.of<ProfileApi>(context, listen: false).getProfile();
      _nameController = TextEditingController(text: map['name']);
      _ytLinkController = TextEditingController(
          text: map['youtube'] == null ? 'www.youtube.com' : map['youtube']);
      _linkedinController = TextEditingController(
          text: map['linkdin'] == null ? 'www.linkedin.com' : map['linkdin']);
      _locationController = TextEditingController(
          text: map['location'] == null ? 'London' : map['location']);
      _initialImage = map["profileimg"];
      setState(() {
        _isLoad = false;
      });
    }
    _isinit = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _submit(_name, _ytLink, _linkedinLink, _location);
              // Navigator.of(context).pushNamed('/project-details');
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
          Container(
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: size.height > diviceSize ? 40 : 30,
                child: Image.asset('assets/icons/Decline.png')),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PageBackground(size: size, imagePath: 'assets/background.png'),
          _isLoad
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
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
                                // Navigator.of(context).pushNamed('/project-details');
                              },
                              child: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  height: 30,
                                  width: 30,
                                  child:
                                      Image.asset('assets/icons/backicon.png')),
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
                                        fontSize:
                                            size.height > diviceSize ? 40 : 22,
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
                          child: Form(
                            key: _formKey,
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
                                            _name,
                                            _nameController,
                                          )
                                        : _formField(
                                            'Name',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Usericon.png',
                                            _name,
                                            _nameController,
                                          ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    size.height > diviceSize
                                        ? _formField(
                                            'Youtube Link',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Lickicon.png',
                                            _ytLink,
                                            _ytLinkController)
                                        : _formField(
                                            'Youtube Link',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Lickicon.png',
                                            _ytLink,
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
                                            'Linkedin',
                                            size.width / 2 - 42,
                                            30,
                                            'assets/icons/Lickicon.png',
                                            _linkedinLink,
                                            _linkedinController)
                                        : _formField(
                                            'Linkedin',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Lickicon.png',
                                            _linkedinLink,
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
                                            _location,
                                            _locationController,
                                          )
                                        : _formField(
                                            'Location',
                                            size.width / 2 - 42,
                                            15,
                                            'assets/icons/Locationicon.png',
                                            _location,
                                            _locationController,
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _formField(
    String lable,
    double width,
    double fontSize,
    String image,
    String usrVal,
    TextEditingController controller,
  ) {
    return Container(
      width: width,
      child: TextFormField(
        validator: lable == 'Name' || lable == 'Location'
            ? (value) {
                if (value.isEmpty) {
                  return 'Please Enter Valid Text';
                }
                return null;
              }
            : (value) {
                Pattern pattern =
                    r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(value) || value.isEmpty) {
                  return 'Please Enter Valid Link';
                }
                return null;
              },
        cursorColor: Colors.white,
        controller: controller,
        onSaved: (value) {
          setState(() {
            if (lable == 'Name') {
              _name = value;
            }
            if (lable == 'Youtube Link') {
              _ytLink = value;
            }
            if (lable == 'Linkedin') {
              _linkedinLink = value;
            }
            if (lable == 'Location') {
              _location = value;
            }
          });
        },
        style: TextStyle(color: Colors.yellow[300], fontSize: fontSize),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 15,
          ),
          hintText: lable,
          hintStyle: TextStyle(color: Colors.amber[300], fontSize: fontSize),
          prefixIcon: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 10,
              child: Image.asset(image),
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

  Future getImageFromCam() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromGal() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
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

  void _submit(
      String name, String ytLink, String linkedinLink, String location) async {
    if (_formKey.currentState.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      _formKey.currentState.save();
      try {
        setState(() {
          _isLoad = true;
        });
        _image == null
            ? await Provider.of<ProfileApi>(context, listen: false)
                .updatePro(_name, _ytLink, _linkedinLink, _location)
            : await Provider.of<ProfileApi>(context, listen: false)
                .updateProWithimg(
                    _name, _ytLink, _linkedinLink, _location, _image);
        setState(() {
          _isLoad = true;
        });
        Navigator.of(context).pushReplacementNamed('/own-profile');
      } catch (e) {
        print(e);
        setState(() {
          _isLoad = true;
        });
      }

      print(_name);
      print(_ytLink);
      print(_linkedinLink);
      print(_location);
      print(_image);
    }
  }
}
