import 'package:flutter/material.dart';
import 'package:login/helpers/iconprovider.dart';
import 'package:login/helpers/tabiconprovider.dart';
import 'package:login/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  _scroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;
    print(maxExtent);
    _scrollController
        .animateTo(maxExtent,
            duration: Duration(seconds: durationDouble.toInt()),
            curve: Curves.linear)
        .then((value) {});
    double maxExtent2 = _scrollController.position.maxScrollExtent;
    double distanceDifference2 = maxExtent - _scrollController.offset;
    double durationDouble2 = distanceDifference2 / speedFactor;
    print(maxExtent2);
    _scrollController2.animateTo(maxExtent2,
        duration: Duration(seconds: durationDouble2.toInt()),
        curve: Curves.linear);
  }

  Widget _formField(
    String lable,
    double width,
    double fontSize,
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
          hintText: lable,
          hintStyle:
              TextStyle(color: Colors.grey, height: 1, fontSize: fontSize),
          icon: ClipOval(
            child: Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white,
                      Colors.amber,
                    ]),
                borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              ),
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                    width: fontSize == 30 ? 50 : 30,
                    height: fontSize == 30 ? 50 : 30,
                    child: Center(
                        child: Icon(
                      lable == 'Name'
                          ? Icons.portrait
                          : lable == 'Email Adress' ? Icons.email : Icons.lock,
                      color: Colors.black87,
                      size: fontSize == 30 ? 30 : 20,
                    ))),
              ),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
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
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<IconProvider>(context);
    final icon = productData.items;
    final tabIconData = Provider.of<TabIconProvider>(context);
    final tabIcon = tabIconData.items;
    Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scroll());

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            width: size.width,
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
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
                                ? _formField('Name', 650, 30)
                                : _formField('Name', 450, 20),
                            SizedBox(
                              height: size.height > diviceSize ? 15 : 5,
                            ),
                            size.height > diviceSize
                                ? _formField('Email Adress', 650, 30)
                                : _formField('Email Adress', 450, 20),
                            SizedBox(
                              height: size.height > diviceSize ? 15 : 5,
                            ),
                            size.height > diviceSize
                                ? _formField('Password', 650, 30)
                                : _formField('Password', 450, 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 28.0),
                                  child: ClipOval(
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Colors.white,
                                              Colors.amberAccent
                                            ]),
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(50.0)),
                                      ),
                                      child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            splashColor: Colors.blue,
                                            child: SizedBox(
                                                width: size.height > diviceSize
                                                    ? 80
                                                    : 50,
                                                height: size.height > diviceSize
                                                    ? 80
                                                    : 50,
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  size: size.height > diviceSize
                                                      ? 40
                                                      : 20,
                                                )),
                                            onTap: _submit,
                                          )),
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
                                  child: Text(
                                    "Members ?",
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontSize:
                                            size.height > diviceSize ? 25 : 15),
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
                        height: size.height > diviceSize ? 110 : 40,
                        width: size.height > diviceSize ? 1000 : 450,
                        child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
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
                                    child: RoundedButton(
                                      onTap: () {
                                        print(icon[i].icon.icon);
                                      },
                                      iconData: size.height > diviceSize
                                          ? tabIcon[i].icon
                                          : icon[i].icon,
                                      radius:
                                          size.height > diviceSize ? 50 : 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: size.height > diviceSize
                                      ? EdgeInsets.only(top: 55.0, left: 75)
                                      : const EdgeInsets.only(
                                          top: 25.0, left: 35),
                                  child: ClipOval(
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.grey[900],
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(50.0)),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: SizedBox(
                                            width: size.height > diviceSize
                                                ? 30
                                                : 12,
                                            height: size.height > diviceSize
                                                ? 30
                                                : 12,
                                            child: Center(
                                              child: Text(
                                                '20%',
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height > diviceSize
                                                            ? 15
                                                            : 6,
                                                    color: Colors.yellowAccent),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          itemCount: icon.length,
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
                            height: size.height > diviceSize ? 110 : 40,
                            width: size.height > diviceSize ? 1000 : 450,
                            child: ListView.builder(
                              controller: _scrollController2,
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              shrinkWrap: true,
                              itemBuilder: (_, i) => Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: size.height > diviceSize
                                        ? EdgeInsets.symmetric(horizontal: 10)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 10),
                                    child: RoundedButton(
                                      onTap: () {
                                        print(icon[i].icon.icon);
                                      },
                                      iconData: size.height > diviceSize
                                          ? tabIcon[i].icon
                                          : icon[i].icon,
                                      radius:
                                          size.height > diviceSize ? 50 : 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: size.height > diviceSize
                                        ? EdgeInsets.only(top: 55.0, left: 75)
                                        : const EdgeInsets.only(
                                            top: 25.0, left: 35),
                                    child: ClipOval(
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(50.0)),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: SizedBox(
                                              width: size.height > diviceSize
                                                  ? 30
                                                  : 12,
                                              height: size.height > diviceSize
                                                  ? 30
                                                  : 12,
                                              child: Center(
                                                child: Text(
                                                  '20%',
                                                  style: TextStyle(
                                                      fontSize: size.height >
                                                              diviceSize
                                                          ? 15
                                                          : 6,
                                                      color:
                                                          Colors.yellowAccent),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              itemCount: icon.length,
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
