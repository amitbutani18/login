import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login/helpers/iconprovider.dart';
import 'package:login/helpers/icons.dart';
import 'package:login/helpers/tabiconprovider.dart';
import 'package:login/screens/roomdetails.dart';
import 'package:login/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final int selectIndex = 0;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  ScrollController _scrollController2 = ScrollController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  double maxExtent;

  AnimationController _controller;
  Animation<double> _easeInAnimation;

  bool clearData = false;
  ScrollController _scrollController = ScrollController();
  var currentOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 100,
        ),
        value: 0.1);
    _easeInAnimation = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _controller.reverse();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    double screenWidth = MediaQuery.of(context).size.width;
    int select = widget.selectIndex > 0 ? widget.selectIndex : 0;
    _scrollController = ScrollController(
      initialScrollOffset: (3000 + select) * (screenWidth - 40) / 7,
    );
  }

  var _email = '';
  var _password = '';

  int speedFactor = 20;

  double diviceSize = 470;

  var end = false;

  _scroll() {
    maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;

    _scrollController.animateTo(maxExtent,
        duration: Duration(seconds: durationDouble.toInt()),
        curve: Curves.linear);

    double maxExtent2 = _scrollController2.position.maxScrollExtent;
    double distanceDifference2 = maxExtent2 - _scrollController2.offset;
    double durationDouble2 = distanceDifference2 / speedFactor;
    _scrollController2.animateTo(maxExtent2,
        duration: Duration(seconds: durationDouble2.toInt()),
        curve: Curves.linear);
  }

  Widget _formField(
    String lable,
    double width,
    double fontSize,
  ) {
    return Container(
      width: width,
      child: TextFormField(
        // focusNode: lable == 'Email' ? emialFocus : passFocus,
        controller: lable == 'Email' ? _emailController : _passwordController,
        onChanged: (value) {
          setState(() {
            lable == 'Email' ? _email = value : _password = value;
          });
        },
        style: TextStyle(color: Colors.yellow[300], fontSize: fontSize),
        obscureText: lable == 'Email' ? false : true,
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
                      lable == 'Email' ? Icons.email : Icons.lock,
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
    _emailController.clear();
    _passwordController.clear();

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    print(_email);
    print(_password);

    Navigator.of(context).push(_createRoute());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RoomDetails(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scroll());

    final productData = Provider.of<IconProvider>(context);
    List icon = productData.items;
    final tabIconData = Provider.of<TabIconProvider>(context);
    final tabIcon = tabIconData.items;
    Size size = MediaQuery.of(context).size;
    double boxSize = size.height > 470 ? 70 : 50;

    if (clearData) {
      _scrollController.jumpTo(3000 * (size.width - 40) / 7);
      clearData = false;
    }

    bool click = false;

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
                  ? EdgeInsets.only(top: 108, left: 55, right: 55, bottom: 55)
                  : EdgeInsets.all(28),
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      width: size.height > diviceSize ? 650 : 400,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          children: <Widget>[
                            size.height > diviceSize
                                ? _formField('Email', 650, 30)
                                : _formField('Email', 450, 20),
                            SizedBox(
                              height: 5,
                            ),
                            size.height > diviceSize
                                ? _formField('Password', 650, 30)
                                : _formField('Password', 450, 20),
                            SizedBox(
                              height: size.height > diviceSize ? 20 : 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: size.height > diviceSize
                                      ? const EdgeInsets.only(top: 18.0)
                                      : const EdgeInsets.only(top: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.forward().then((value) {
                                        _controller.reverse().then((value) {
                                          _submit();
                                        });
                                      });
                                    },
                                    child: ScaleTransition(
                                      scale: _easeInAnimation,
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                Colors.white,
                                                Colors.amberAccent
                                              ]),
                                        ),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: size.height > diviceSize
                                                ? 40
                                                : 30,
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: size.height > diviceSize
                                                  ? 40
                                                  : 20,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height > diviceSize ? 20 : 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed('/own-profile'),
                                  child: Text(
                                    "Amneia?",
                                    style: TextStyle(
                                        color: Colors.yellow,
                                        fontSize:
                                            size.height > diviceSize ? 25 : 15),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed('/details'),
                                  child: Text(
                                    "Join?",
                                    style: TextStyle(
                                        color: Colors.yellow,
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
                        ? const EdgeInsets.only(top: 88.0)
                        : const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTapCancel: () {
                        // print(d.localPosition);
                        _scroll();
                      },
                      onTapDown: (d) {
                        setState(() {
                          click = true;
                        });
                      },
                      onTapUp: (d) {
                        // print(d.localPosition);
                        _scroll();
                      },
                      child: Container(
                        height: size.height > diviceSize ? 100 : boxSize,
                        width:
                            size.height > diviceSize ? size.width : size.width,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemExtent: size.width / 9,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (_, i) => Stack(
                            children: <Widget>[
                              Padding(
                                padding: size.height > diviceSize
                                    ? EdgeInsets.symmetric(horizontal: 25)
                                    : const EdgeInsets.symmetric(horizontal: 0),
                                child: RoundedButton(
                                  key: ValueKey(i * 1000000),
                                  onTap: () {
                                    print(icon[i % icon.length].icon.icon);
                                    _scroll();
                                  },
                                  iconData: size.height > diviceSize
                                      ? tabIcon[i % icon.length].icon
                                      : icon[i % icon.length].icon,
                                  radius: 40,
                                ),
                              ),
                              Padding(
                                padding: size.height > diviceSize
                                    ? EdgeInsets.only(top: 38.0, left: 85)
                                    : const EdgeInsets.only(
                                        top: 25.0, left: 50),
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
                                              : 25,
                                          height: size.height > diviceSize
                                              ? 30
                                              : 25,
                                          child: Center(
                                            child: Text(
                                              '20%',
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height > diviceSize
                                                          ? 15
                                                          : 10,
                                                  color: Colors.amber),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          itemCount: icon.length * 10000,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: size.height > diviceSize
                        ? const EdgeInsets.only(top: 0.0)
                        : const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Container(
                        height: size.height > diviceSize ? 100 : boxSize,
                        width:
                            size.height > diviceSize ? size.width : size.width,
                        child: ListView.builder(
                          controller: _scrollController2,
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          shrinkWrap: true,
                          itemBuilder: (_, i) => Container(
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: size.height > diviceSize
                                      ? EdgeInsets.symmetric(horizontal: 25)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 0),
                                  child: RoundedButton(
                                    onTap: () {
                                      print(icon[i].icon.icon);
                                    },
                                    iconData: size.height > diviceSize
                                        ? tabIcon[i].icon
                                        : icon[i].icon,
                                    radius: 40,
                                  ),
                                ),
                                Padding(
                                  padding: size.height > diviceSize
                                      ? EdgeInsets.only(top: 38.0, left: 85)
                                      : const EdgeInsets.only(
                                          top: 25.0, left: 50),
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
                                                : 25,
                                            height: size.height > diviceSize
                                                ? 30
                                                : 25,
                                            child: Center(
                                              child: Text(
                                                '20%',
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height > diviceSize
                                                            ? 15
                                                            : 10,
                                                    color: Colors.amber),
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

                  // BottomIcon2(
                  //     size: size,
                  //     diviceSize: diviceSize,
                  //     scrollController2: _scrollController2,
                  //     tabIcon: tabIcon,
                  //     icon: icon),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _tap(TapUpDetails d) {
  print(d.globalPosition);
}

class BottomIcon1 extends StatelessWidget {
  const BottomIcon1({
    Key key,
    @required this.size,
    @required this.diviceSize,
    @required ScrollController scrollController,
    @required this.tabIcon,
    @required this.icon,
  })  : _scrollController = scrollController,
        super(key: key);

  final Size size;
  final double diviceSize;
  final ScrollController _scrollController;
  final List<Iconss> tabIcon;
  final List<Iconss> icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: size.height > diviceSize
          ? const EdgeInsets.only(top: 148.0)
          : const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          height: size.height > diviceSize ? 70 : 50,
          width: size.width,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (_, i) => Stack(
              children: <Widget>[
                Padding(
                  padding: size.height > diviceSize
                      ? const EdgeInsets.symmetric(horizontal: 25)
                      : const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipOval(
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.blue,
                          child: SizedBox(
                            width: size.height > diviceSize ? 70 : 50,
                            height: size.height > diviceSize ? 70 : 50,
                            child: ShaderMask(
                              shaderCallback: (bounds) => RadialGradient(
                                colors: [
                                  Colors.white,
                                  Colors.yellow[400],
                                  Colors.white
                                ],
                              ).createShader(bounds),
                              child: size.height > diviceSize
                                  ? tabIcon[i].icon
                                  : icon[i].icon,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: size.height > diviceSize
                      ? EdgeInsets.only(top: 38.0, left: 75)
                      : const EdgeInsets.only(top: 25.0, left: 45),
                  child: ClipOval(
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: SizedBox(
                            width: size.height > diviceSize ? 30 : 25,
                            height: size.height > diviceSize ? 30 : 30,
                            child: Center(
                              child: Text(
                                '20%',
                                style: TextStyle(
                                    fontSize:
                                        size.height > diviceSize ? 15 : 10,
                                    color: Colors.amber),
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
      ),
    );
  }
}

class BottomIcon2 extends StatelessWidget {
  const BottomIcon2({
    Key key,
    @required this.size,
    @required this.diviceSize,
    @required ScrollController scrollController2,
    @required this.tabIcon,
    @required this.icon,
  })  : _scrollController2 = scrollController2,
        super(key: key);

  final Size size;
  final double diviceSize;
  final ScrollController _scrollController2;
  final List<Iconss> tabIcon;
  final List<Iconss> icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height > diviceSize ? 70 : 50,
              width: size.width,
              child: ListView.builder(
                controller: _scrollController2,
                scrollDirection: Axis.horizontal,
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (_, i) => Stack(
                  children: <Widget>[
                    Padding(
                      padding: size.height > diviceSize
                          ? const EdgeInsets.symmetric(horizontal: 25)
                          : const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipOval(
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(50.0)),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.blue,
                              child: SizedBox(
                                width: size.height > diviceSize ? 70 : 50,
                                height: size.height > diviceSize ? 70 : 50,
                                child: ShaderMask(
                                  shaderCallback: (bounds) => RadialGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.yellow[400],
                                      Colors.white
                                    ],
                                  ).createShader(bounds),
                                  child: size.height > diviceSize
                                      ? tabIcon[i].icon
                                      : icon[i].icon,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: size.height > diviceSize
                          ? EdgeInsets.only(top: 38.0, left: 75)
                          : const EdgeInsets.only(top: 25.0, left: 45),
                      child: ClipOval(
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(50.0)),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: SizedBox(
                                width: size.height > diviceSize ? 30 : 25,
                                height: size.height > diviceSize ? 30 : 25,
                                child: Center(
                                  child: Text(
                                    '20%',
                                    style: TextStyle(
                                        fontSize:
                                            size.height > diviceSize ? 15 : 10,
                                        color: Colors.amber),
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
    );
  }
}
