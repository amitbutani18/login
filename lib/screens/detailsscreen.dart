import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login/helpers/bottomdownsliderprovider.dart';
import 'package:login/helpers/bottomupsliderprovider.dart';
import 'package:login/helpers/iconprovider.dart';
import 'package:login/helpers/tabiconprovider.dart';
import 'package:login/widgets/ease_in_widget.dart';
import 'package:login/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final int selectIndex = 0;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  int speedFactor = 20;

  var _name = '';
  var _email = '';
  var _password = '';

  double diviceSize = 470;
  bool clearData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    double screenWidth = MediaQuery.of(context).size.width;
    int select = widget.selectIndex > 0 ? widget.selectIndex : 0;
    _scrollController = ScrollController(
      initialScrollOffset: (3000 + select) * (screenWidth - 40) / 7,
    );
    _scrollController2 = ScrollController(
        initialScrollOffset: (3000 + select) * (screenWidth - 40) / 7);
  }

  _scroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;
    _scrollController.animateTo(maxExtent,
        duration: Duration(seconds: durationDouble.toInt()),
        curve: Curves.linear);

    double maxExtent2 = _scrollController.position.maxScrollExtent;
    double distanceDifference2 = maxExtent - _scrollController.offset;
    double durationDouble2 = distanceDifference2 / speedFactor;
    _scrollController2.animateTo(maxExtent2,
        duration: Duration(seconds: durationDouble2.toInt()),
        curve: Curves.linear);
  }

  Widget _formField(
    String lable,
    double width,
    double fontSize,
    String image,
  ) {
    // FocusNode myFocusNode = new FocusNode();
    return Container(
      width: width,
      child: TextFormField(
        // focusNode: myFocusNode,
        onChanged: (value) {
          setState(() {
            lable == 'Name'
                ? _name = value
                : lable == 'Password' ? _password = value : _email = value;
          });
        },
        controller: lable == 'Name'
            ? _nameController
            : lable == 'Password' ? _passwordController : _emailController,
        style: TextStyle(color: Colors.yellow[300], fontSize: fontSize),
        obscureText:
            lable == 'Name' ? false : lable == 'Password' ? true : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 15,
          ),
          hintText: lable,
          hintStyle: TextStyle(
              color: Colors.amber[300], height: 1, fontSize: fontSize),
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

  void _submit() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    _emailController.clear();
    _nameController.clear();
    _passwordController.clear();

    print(_name);
    print(_email);
    print(_password);

    Navigator.of(context).pushNamed('/pickroom');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scroll());

    final productData = Provider.of<IconProvider>(context);
    final icon = productData.items;
    final tabIconData = Provider.of<TabIconProvider>(context);
    final tabIcon = tabIconData.items;
    final bottomUpIconData = Provider.of<BottomUpSliderProvider>(context);
    final bottomUpSlider = bottomUpIconData.items;
    final bottomDownIconData = Provider.of<BottomDownSliderProvider>(context);
    final bottomDownSlider = bottomDownIconData.items;
    Size size = MediaQuery.of(context).size;

    if (clearData) {
      _scrollController.jumpTo(3000 * (size.width - 40) / 7);
      _scrollController2.jumpTo(3000 * (size.width - 40) / 7);
      clearData = false;
    }

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            width: size.width,
            child: Image.asset(
              'assets/icons/loginbackground.png',
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: size.height > diviceSize
                  ? EdgeInsets.only(top: 98, left: 48, right: 48, bottom: 48)
                  : EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      width: size.height > diviceSize ? 700 : 450,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          children: <Widget>[
                            size.height > diviceSize
                                ? _formField(
                                    'Name', 650, 30, 'assets/icons/user.png')
                                : _formField(
                                    'Name', 450, 15, 'assets/icons/user.png'),
                            SizedBox(
                              height: size.height > diviceSize ? 15 : 5,
                            ),
                            size.height > diviceSize
                                ? _formField('Email Address', 650, 30,
                                    'assets/icons/mail.png')
                                : _formField('Email Address', 450, 15,
                                    'assets/icons/mail.png'),
                            SizedBox(
                              height: size.height > diviceSize ? 15 : 5,
                            ),
                            size.height > diviceSize
                                ? _formField('Password', 650, 30,
                                    'assets/icons/password.png')
                                : _formField('Password', 450, 15,
                                    'assets/icons/password.png'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: size.height > diviceSize
                                      ? const EdgeInsets.only(top: 18.0)
                                      : const EdgeInsets.only(top: 8.0),
                                  child: GestureDetector(
                                    onTap: _submit,
                                    child: Container(
                                      child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: size.height > diviceSize
                                              ? 40
                                              : 30,
                                          child: Image.asset(
                                              'assets/icons/loginbubble.png')),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height > diviceSize ? 20 : 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pushNamed('/what'),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.amber[300],
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Members ?",
                                      style: TextStyle(
                                          color: Colors.amber[300],
                                          fontSize: size.height > diviceSize
                                              ? 25
                                              : 15),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: size.height > diviceSize
                        ? const EdgeInsets.only(top: 98.0)
                        : const EdgeInsets.only(top: 0.0),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 80),
                        height: size.height > diviceSize ? 110 : 40,
                        width: size.height > diviceSize ? 1000 : size.width,
                        child: ListView.builder(
                          itemExtent: size.width / 9,
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, i) => Container(
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: size.height > diviceSize
                                      ? EdgeInsets.symmetric(horizontal: 10)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 0),
                                  child: Padding(
                                    padding: size.height > diviceSize
                                        ? EdgeInsets.symmetric(horizontal: 0)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 10),
                                    child: EaseInWidget(
                                        radius: 30,
                                        image: bottomUpSlider[
                                                i % bottomUpSlider.length]
                                            .image,
                                        onTap: () {
                                          print(bottomUpSlider[
                                                  i % bottomUpSlider.length]
                                              .image);
                                          _scroll();
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          itemCount: bottomUpSlider.length * 10000,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 80),
                            height: size.height > diviceSize ? 110 : 40,
                            width: size.height > diviceSize ? 1000 : size.width,
                            child: ListView.builder(
                              controller: _scrollController2,
                              scrollDirection: Axis.horizontal,
                              itemExtent: size.width / 9,
                              reverse: true,
                              shrinkWrap: true,
                              itemBuilder: (_, i) => Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: size.height > diviceSize
                                        ? EdgeInsets.symmetric(horizontal: 10)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 10),
                                    child: EaseInWidget(
                                        radius: 30,
                                        image: bottomDownSlider[
                                                i % bottomDownSlider.length]
                                            .image,
                                        onTap: () {
                                          print(bottomDownSlider[
                                                  i % bottomDownSlider.length]
                                              .image);
                                          _scroll();
                                        }),
                                  ),
                                ],
                              ),
                              itemCount: bottomDownSlider.length * 10000,
                            ),
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
}
