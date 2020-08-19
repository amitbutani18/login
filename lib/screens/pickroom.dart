import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:login/helpers/bottomdownsliderprovider.dart';
import 'package:login/helpers/bottomupsliderprovider.dart';
import 'package:login/helpers/iconprovider.dart';
import 'package:login/helpers/imageprovider.dart';
import 'package:login/helpers/leftsideslidericonprovider.dart';
import 'package:login/helpers/rightsidesliderprovider.dart';
import 'package:login/helpers/tabiconprovider.dart';
import 'package:login/helpers/topslidericonprovider.dart';
import 'package:login/widgets/datepick.dart';
import 'package:login/widgets/ease_in_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class PickRoom extends StatefulWidget {
  final int selectIndex = 0;

  @override
  _PickRoomState createState() => _PickRoomState();
}

class _PickRoomState extends State<PickRoom> with AfterLayoutMixin<PickRoom> {
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();
  ScrollController _scrollController4 =
      ScrollController(initialScrollOffset: 20000);
  ScrollController _scrollController5 = ScrollController();

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  PageController _pagecon =
      new PageController(initialPage: 100, viewportFraction: 0.1);

  double divSize = 550;

  int speedFactor = 20;

  bool clearData = false;

  String noti = '';

  double oldValue = 0;

  _scroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;
    // print(maxExtent);
    _scrollController
        .animateTo(maxExtent,
            duration: Duration(seconds: durationDouble.toInt()),
            curve: Curves.linear)
        .then((value) {});
    double maxExtent2 = _scrollController.position.maxScrollExtent;
    double distanceDifference2 = maxExtent - _scrollController.offset;
    double durationDouble2 = distanceDifference2 / speedFactor;
    // print(durationDouble2);
    _scrollController2.animateTo(maxExtent2,
        duration: Duration(seconds: durationDouble2.toInt()),
        curve: Curves.linear);

    // double maxExtent3 = _scrollController.position.maxScrollExtent;
    // double distanceDifference3 = maxExtent3 - _scrollController.offset;
    // double durationDouble3 = distanceDifference3 / speedFactor;
    // // print(maxExtent3);
    // _scrollController3.animateTo(maxExtent3,
    //     duration: Duration(seconds: durationDouble3.toInt()),
    //     curve: Curves.linear);
  }

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

    // _scrollController3 =
    //     ScrollController(initialScrollOffset: (3000 + select) * (500 - 40) / 7);
  }

  Widget _formField(String lable, double width, double fontSize, String image) {
    // FocusNode myFocusNode = new FocusNode();
    return Container(
      width: width,
      child: TextFormField(
        cursorColor: Colors.black,
        // focusNode: myFocusNode,
        style: TextStyle(
          color: Colors.yellow[300],
          fontSize: fontSize,
        ),

        decoration: InputDecoration(
          hintText: lable,
          hintStyle:
              TextStyle(color: Colors.amber, height: 1.5, fontSize: fontSize),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          ),
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
                    child: Image.asset(image),
                  ),
                ),
              ),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController3.addListener(() async {
      // print(_scrollController3.position.pixels);
      var distance = oldValue - _scrollController3.position.pixels;
      if (distance > 50 || distance < -50) {
        // print("distance");
        // print(distance);
        HapticFeedback.vibrate();
        // if (await Vibration.hasAmplitudeControl()) {
        //   Vibration.vibrate(duration: 100, amplitude: 128);
        // }
        // if (await Vibration.hasVibrator()) {
        //   Vibration.vibrate();
        // }
        oldValue = _scrollController3.position.pixels;
      }

      if (_scrollController3.position.atEdge) {
        if (_scrollController3.position.pixels == 0) {
          // you are at top position
          print("top");
        } else {
          // you are at bottom position
          print("bottom");
        }
      }
    });
    _scrollController4.addListener(() async {
      // print(_scrollController4.position.pixels);
      var distance = oldValue - _scrollController4.position.pixels;
      if (distance > 50 || distance < -50) {
        // print("distance");
        // print(distance);
        HapticFeedback.vibrate();
        // if (await Vibration.hasAmplitudeControl()) {
        //   Vibration.vibrate(duration: 100, amplitude: 128);
        // }
        // if (await Vibration.hasVibrator()) {
        //   Vibration.vibrate();
        // }
        oldValue = _scrollController4.position.pixels;
      }

      if (_scrollController4.position.atEdge) {
        if (_scrollController4.position.pixels == 0) {
          // you are at top position
          print("top");
        } else {
          // you are at bottom position
          print("bottom");
        }
      }
    });
    _scrollController5.addListener(() async {
      print(_scrollController5.position.pixels);
      var distance = oldValue - _scrollController5.position.pixels;
      if (distance > 50 || distance < -50) {
        print("distance");
        print(distance);
        HapticFeedback.lightImpact();
        // if (await Vibration.hasAmplitudeControl()) {
        //   Vibration.vibrate(duration: 100, amplitude: 128);
        // }
        // if (await Vibration.hasVibrator()) {
        //   Vibration.vibrate();
        // }
        oldValue = _scrollController5.position.pixels;
      }

      if (_scrollController5.position.atEdge) {
        if (_scrollController5.position.pixels == 0) {
          // you are at top position
          print("top");
        } else {
          // you are at bottom position
          print("bottom");
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    _scrollController4.dispose();
    _scrollController5.dispose();
    _pagecon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scroll();
    });

    final productData = Provider.of<IconProvider>(context);
    final icon = productData.items;
    final tabIconData = Provider.of<TabIconProvider>(context);
    final tabIcon = tabIconData.items;
    final imageData = Provider.of<ImagesProvider>(context);
    final imageUrl = imageData.items;
    final sliderIconData = Provider.of<TopSliderIconProvider>(context);
    final slider = sliderIconData.items;
    final leftIconData = Provider.of<LeftSideSliderIconProvider>(context);
    final leftSlider = leftIconData.items;
    final rightIconData = Provider.of<RightSideSliderIconProvider>(context);
    final rightSlider = rightIconData.items;
    final bottomUpSliderData = Provider.of<BottomUpSliderProvider>(context);
    final bottomUpSlider = bottomUpSliderData.items;
    final bottomDownSliderData = Provider.of<BottomDownSliderProvider>(context);
    final bottomDownSlider = bottomDownSliderData.items;
    Size size = MediaQuery.of(context).size;

    if (clearData) {
      _scrollController.jumpTo(3000 * (size.width - 40) / 7);
      _scrollController2.jumpTo(3000 * (size.width - 40) / 7);
      // _scrollController3.jumpTo(3000 * (size.width - 40) / 7);
      clearData = false;
    }

    return Scaffold(
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
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ShaderMask(
                          shaderCallback: (bounds) => RadialGradient(
                            colors: [
                              Colors.white,
                              Colors.yellow[400],
                              Colors.white
                            ],
                          ).createShader(bounds),
                          child: CircleAvatar(
                            radius: size.height > divSize ? 20 : 10,
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                              'assets/icons/Sidebar.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        size.height > divSize
                            ? Container()
                            : Center(
                                child: Container(
                                  height: 50,
                                  width: 480,
                                  child: ListView.builder(
                                    controller: _scrollController5,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, i) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: EaseInWidget(
                                          radius: 30,
                                          image:
                                              slider[i % slider.length].image,
                                          onTap: () {
                                            print("Hello");
                                          }),
                                    ),
                                    itemCount: slider.length * 10000,
                                  ),
                                ),
                              ),
                        ShaderMask(
                          shaderCallback: (bounds) => RadialGradient(
                            colors: [
                              Colors.white,
                              Colors.yellow[400],
                              Colors.white
                            ],
                          ).createShader(bounds),
                          child: CircleAvatar(
                            radius: size.height > divSize ? 20 : 10,
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                              'assets/icons/home.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  size.height > divSize
                      ? Center(
                          child: Container(
                            height: size.height > divSize ? 80 : 40,
                            width: size.height > divSize ? 550 : 100,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, i) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: EaseInWidget(
                                      radius: 30,
                                      image: slider[i % slider.length].image,
                                      onTap: () {
                                        print("Hello");
                                      })),
                              itemCount: slider.length * 10000,
                            ),
                          ),
                        )
                      : Container(),
                  size.height > divSize
                      ? SizedBox(
                          height: 10,
                        )
                      : Container(),
                  Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: size.height > divSize ? 480 : 200,
                            width: size.height > divSize ? 80 : 60,
                            child: ListView.builder(
                              controller: _scrollController4,
                              key: ValueKey(4),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (_, i) => Padding(
                                padding: size.height > divSize
                                    ? const EdgeInsets.symmetric(vertical: 5)
                                    : const EdgeInsets.symmetric(vertical: 0),
                                child: EaseInWidget(
                                    radius: 30,
                                    image: rightSlider[i % rightSlider.length]
                                        .image,
                                    onTap: () {
                                      print(rightSlider[i % rightSlider.length]
                                          .image);
                                    }),
                              ),
                              itemCount: rightSlider.length * 100,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: size.height > divSize
                                    ? const EdgeInsets.only(top: 48.0)
                                    : const EdgeInsets.only(top: 18.0),
                                child: size.height > divSize
                                    ? _formField('Hotel', 650, 30,
                                        'assets/icons/What.png')
                                    : _formField('Hotel', 450, 18,
                                        'assets/icons/What.png'),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: size.height > divSize
                                        ? _formField('London', 350, 30,
                                            'assets/icons/Where.png')
                                        : _formField('London', 230, 18,
                                            'assets/icons/Where.png'),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  DatePick(),
                                ],
                              ),
                              SizedBox(
                                height: size.height > divSize ? 30 : 10,
                              ),
                              Text(
                                "Hotels",
                                style: TextStyle(
                                    fontSize: size.height > divSize ? 22 : 15,
                                    color: Colors.white54,
                                    decoration: TextDecoration.underline,
                                    letterSpacing: 1),
                              ),
                              size.height > divSize
                                  ? Container(
                                      width: 700,
                                      height: 200,
                                      color: Colors.transparent,
                                      child: GridView.builder(
                                        // controller: _scrollController3,
                                        itemCount: 5,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                // maxCrossAxisExtent: 200,
                                                childAspectRatio: 0.7 / 0.2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10,
                                                crossAxisCount: 3),
                                        itemBuilder: (_, i) => Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Container(
                                                  child: Image.network(
                                                      imageUrl[i].imageUrl),
                                                  height: 70,
                                                  width: 70,
                                                  color: Colors.grey[850],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "20% OFF",
                                                    style: TextStyle(
                                                        fontSize: 23,
                                                        color:
                                                            Colors.amberAccent,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 450,
                                      height: 60,
                                      padding: EdgeInsets.only(top: 10),
                                      child: ListView.builder(
                                        key: ValueKey(5),
                                        physics: BouncingScrollPhysics(),
                                        // controller: _scrollController3,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imageUrl.length,
                                        itemBuilder: (_, i) => Container(
                                          width: 150,
                                          height: 450,
                                          color: Colors.transparent,
                                          child: Row(
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Container(
                                                  child: Image.network(
                                                      imageUrl[i].imageUrl),
                                                  height: 50,
                                                  width: 50,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "20% OFF",
                                                style: TextStyle(
                                                    color: Colors.amberAccent,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          Container(
                            height: size.height > divSize ? 480 : 200,
                            width: size.height > divSize ? 80 : 60,
                            // child: NotificationListener<ScrollNotification>(
                            //   key: PageStorageKey(context),
                            //   onNotification: (ScrollNotification scrollInfo) {
                            //     if (scrollInfo is ScrollStartNotification) {
                            //       _onStartScroll(scrollInfo.metrics);
                            //       print(scrollInfo.metrics.axisDirection);
                            //     } else if (scrollInfo
                            //         is ScrollUpdateNotification) {
                            //       _onUpdateScroll(scrollInfo.metrics);
                            //     } else if (scrollInfo
                            //         is ScrollEndNotification) {
                            //       _onEndScroll(scrollInfo.metrics);
                            //     }
                            //     print(noti);
                            //     return true;
                            //   },
                            child: ListView.builder(
                              key: ValueKey(3),
                              controller: _scrollController3,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (_, i) => Padding(
                                padding: size.height > divSize
                                    ? const EdgeInsets.symmetric(vertical: 5)
                                    : const EdgeInsets.symmetric(vertical: 0),
                                child: EaseInWidget(
                                    radius: 30,
                                    image:
                                        leftSlider[i % leftSlider.length].image,
                                    onTap: () {
                                      print(leftSlider[i % leftSlider.length]
                                          .image);
                                    }),
                                // child: RoundedButton(
                                //   onTap: () {
                                //     print(icon[i].icon.icon);
                                //   },
                                //   iconData: size.height > divSize
                                //       ? tabIcon[i].icon
                                //       : leftSlider[i].image,
                                //   radius: size.height > divSize ? 50 : 30,
                                // ),
                              ),
                              itemCount: leftSlider.length * 100,
                            ),
                            // ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: size.height > divSize
                            ? const EdgeInsets.only(top: 480.0)
                            : const EdgeInsets.only(top: 240.0),
                        child: Center(
                          child: GestureDetector(
                            onTapCancel: () {
                              _scroll();
                            },
                            onTapDown: (d) {
                              // .forward();
                            },
                            onTapUp: (d) {
                              _scroll();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              height: size.height > divSize ? 80 : 40,
                              width: size.height > divSize ? 680 : size.width,
                              child: ListView.builder(
                                key: ValueKey(1),
                                itemExtent: size.width / 9,
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (_, i) => Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: size.height > divSize
                                          ? const EdgeInsets.symmetric(
                                              horizontal: 15)
                                          : const EdgeInsets.symmetric(
                                              horizontal: 5),
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
                                  ],
                                ),
                                itemCount: bottomUpSlider.length * 10000,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: size.height > divSize
                            ? const EdgeInsets.only(top: 570.0)
                            : const EdgeInsets.only(top: 280.0),
                        child: Center(
                          child: GestureDetector(
                            onTapCancel: () {
                              _scroll();
                            },
                            onTapDown: (d) {},
                            onTapUp: (d) {
                              _scroll();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              height: size.height > divSize ? 80 : 40,
                              width: size.height > divSize ? 680 : size.width,
                              child: NotificationListener<ScrollNotification>(
                                onNotification: (notification) {
                                  if (notification is ScrollEndNotification) {
                                    print("End");
                                    _scroll();
                                  }
                                  return true;
                                },
                                child: ListView.builder(
                                  key: ValueKey(2),
                                  itemExtent: size.width / 9,
                                  controller: _scrollController2,
                                  reverse: true,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (_, i) => Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: size.height > divSize
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 15)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 5),
                                        child: EaseInWidget(
                                            radius: 30,
                                            image: bottomDownSlider[
                                                    i % bottomDownSlider.length]
                                                .image,
                                            onTap: () {
                                              print(bottomDownSlider[i %
                                                      bottomDownSlider.length]
                                                  .image);
                                              _scroll();
                                            }),
                                      ),
                                    ],
                                  ),
                                  itemCount: bottomDownSlider.length * 10000,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    showHelloWorld();
  }

  void showHelloWorld() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text('Hello World'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('DISMISS'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
