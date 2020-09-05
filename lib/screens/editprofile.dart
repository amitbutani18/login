import 'package:flutter/material.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/pagetitle.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var diviceSize = 470;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ytLinkController = TextEditingController();
  TextEditingController _linkedinController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  String _name;
  String _ytLink;
  String _linkedinLink;
  String _location;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: size.height > diviceSize ? 40 : 30,
                child: Image.asset('assets/icons/loginbubble.png')),
          ),
          SizedBox(
            width: 25,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed('/project-details');
            },
            child: Container(
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: size.height > diviceSize ? 40 : 30,
                  child: Image.asset('assets/icons/loginbubble.png')),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PageBackground(size: size, imagePath: 'assets/background.png'),
          Padding(
            padding: size.height > diviceSize
                ? const EdgeInsets.all(28.0)
                : const EdgeInsets.only(top: 18, right: 18, left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                PageTitle(
                    size: size, diviceSize: diviceSize, title: "Edit Profile"),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: size.height > diviceSize
                        ? const EdgeInsets.symmetric(horizontal: 28.0)
                        : const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 50),
                          child: CircleAvatar(
                            radius: size.height > diviceSize ? 70 : 50,
                            backgroundColor: Colors.yellow,
                            backgroundImage: NetworkImage(
                                'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            size.height > diviceSize
                                ? _formField('Name', size.width / 2 - 42, 30,
                                    'assets/icons/user.png', _nameController)
                                : _formField('Name', size.width / 2 - 42, 15,
                                    'assets/icons/user.png', _nameController),
                            SizedBox(
                              width: 12,
                            ),
                            size.height > diviceSize
                                ? _formField(
                                    'Youtube Link',
                                    size.width / 2 - 42,
                                    30,
                                    'assets/icons/user.png',
                                    _ytLinkController)
                                : _formField(
                                    'Youtube Link',
                                    size.width / 2 - 42,
                                    15,
                                    'assets/icons/user.png',
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
                                    'assets/icons/user.png',
                                    _linkedinController)
                                : _formField(
                                    'Linkedin',
                                    size.width / 2 - 42,
                                    15,
                                    'assets/icons/user.png',
                                    _linkedinController),
                            SizedBox(
                              width: 12,
                            ),
                            size.height > diviceSize
                                ? _formField(
                                    'Location',
                                    size.width / 2 - 42,
                                    30,
                                    'assets/icons/user.png',
                                    _locationController,
                                  )
                                : _formField(
                                    'Location',
                                    size.width / 2 - 42,
                                    15,
                                    'assets/icons/user.png',
                                    _locationController,
                                  ),
                          ],
                        ),
                      ],
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
        validator: (value) {
          if (value.isEmpty) {
            return 'Please Enter Valid Email';
          }
          return null;
        },
        cursorColor: Colors.white,
        controller: controller,
        onChanged: (value) {
          setState(() {
            _name = value;
          });
        },
        style: TextStyle(color: Colors.yellow[300], fontSize: fontSize),
        obscureText: lable == 'Email' ? false : true,
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
}
