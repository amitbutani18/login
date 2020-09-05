import 'package:flutter/material.dart';
import 'package:login/API/logout.dart';
import 'package:login/helpers/slider/bottomdownsliderprovider.dart';
import 'package:login/helpers/slider/bottomupsliderprovider.dart';
import 'package:login/helpers/citylist.dart';
import 'package:login/helpers/imageprovider.dart';
import 'package:login/helpers/slider/leftsideslidericonprovider.dart';
import 'package:login/helpers/slider/rightsidesliderprovider.dart';
import 'package:login/helpers/slider/topslidericonprovider.dart';
import 'package:login/widgets/datepick.dart';
import 'package:login/widgets/ease_in_widget.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class PickRoom extends StatefulWidget {
  final int selectIndex = 0;

  @override
  _PickRoomState createState() => _PickRoomState();
}

class _PickRoomState extends State<PickRoom> {
  ScrollController _scrollController;
  ScrollController _scrollController2;
  ScrollController _scrollController3;
  ScrollController _scrollController4;
  ScrollController _scrollController5;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PageController _pagecon =
      new PageController(initialPage: 100, viewportFraction: 0.1);

  double divSize = 550;

  int speedFactor = 20;

  bool clearData = false;

  String noti = '';

  double oldValue = 0;
  var _hotelValue = 'Hotel';
  var _location = 'London';
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    print("In did");
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<RightSideSliderIconProvider>(context, listen: false)
            .setIcon();
        await Provider.of<LeftSideSliderIconProvider>(context, listen: false)
            .setIcon();
        await Provider.of<BottomUpSliderProvider>(context, listen: false)
            .setIcon();
        await Provider.of<BottomDownSliderProvider>(context, listen: false)
            .setIcon();
        await Provider.of<CityList>(context, listen: false).fetchCity();
      } catch (error) {
        print(error);
      }

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    double screenWidth = MediaQuery.of(context).size.width;
    int select = widget.selectIndex > 0 ? widget.selectIndex : 0;
    _scrollController = ScrollController(
      initialScrollOffset: (3000 + select) * (screenWidth - 40) / 7,
    );
    _scrollController2 = ScrollController(
        initialScrollOffset: (3000 + select) * (screenWidth - 40) / 7);
  }

  @override
  void initState() {
    super.initState();
    // print("Amit" + DateTime.now().toIso8601String());
    _scrollController = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = ScrollController();
    _scrollController4 = ScrollController();
    _scrollController5 = ScrollController();
    _scrollController3.addListener(() async {
      // print(_scrollController3.position.pixels);
      var distance = oldValue - _scrollController3.position.pixels;
      if (distance > 50 || distance < -50) {
        // print("distance");
        // print(distance);
        HapticFeedback.lightImpact();

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
      var distance = oldValue - _scrollController4.position.pixels;
      if (distance > 50 || distance < -50) {
        HapticFeedback.lightImpact();

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
      // print("Amit1" + DateTime.now().toIso8601String());

      _scroll();
    });

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
    final cityList = Provider.of<CityList>(context).items;
    Size size = MediaQuery.of(context).size;

    if (clearData) {
      _scrollController.jumpTo(3000 * (size.width - 40) / 7);
      _scrollController2.jumpTo(3000 * (size.width - 40) / 7);
      // _scrollController3.jumpTo(3000 * (size.width - 40) / 7);
      clearData = false;
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        width: 70,
        color: Color.fromRGBO(49, 49, 49, 0.7),
        child: Drawer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              color: Colors.amber,
              icon: Icon(Icons.settings),
              onPressed: () async {
                Navigator.of(context).pushReplacementNamed('/settings');
              },
            ),
            IconButton(
              color: Colors.amber,
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await Provider.of<LogOut>(context, listen: false).logOut();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        )),
      ),
      body: Stack(
        children: <Widget>[
          PageBackground(size: size, imagePath: 'assets/background.png'),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
                ))
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 18, right: 18),
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
                                child: GestureDetector(
                                  onTap: () {
                                    print("hello");
                                    _scaffoldKey.currentState.openDrawer();
                                  },
                                  child: CircleAvatar(
                                    radius: size.height > divSize ? 20 : 10,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                      'assets/icons/Sidebar.png',
                                      fit: BoxFit.fill,
                                    ),
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
                                                image: slider[i % slider.length]
                                                    .image,
                                                secondImage:
                                                    slider[i % slider.length]
                                                        .image,
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          '/room-details');
                                                  print("Hello");
                                                }),
                                          ),
                                          itemCount: slider.length * 10000,
                                        ),
                                      ),
                                    ),
                              GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushNamed('/service-provider'),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        child: EaseInWidget(
                                            radius: 30,
                                            image:
                                                slider[i % slider.length].image,
                                            secondImage:
                                                slider[i % slider.length].image,
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed('/room-details');
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
                                          ? const EdgeInsets.symmetric(
                                              vertical: 5)
                                          : const EdgeInsets.symmetric(
                                              vertical: 0),
                                      child: EaseInWidget(
                                          radius: 30,
                                          image: rightSlider[
                                                  i % rightSlider.length]
                                              .image,
                                          secondImage: rightSlider[
                                                  i % rightSlider.length]
                                              .image,
                                          onTap: () {
                                            setState(() {
                                              _hotelValue = rightSlider[
                                                      i % rightSlider.length]
                                                  .title;
                                            });
                                            print(rightSlider[
                                                    i % rightSlider.length]
                                                .title);
                                            print(rightSlider[
                                                    i % rightSlider.length]
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18.0),
                                          child: size.height > divSize
                                              ? _formField('London', 350, 30,
                                                  'assets/icons/Where.png')
                                              : GestureDetector(
                                                  onTap: () =>
                                                      _showMyDialog(cityList),
                                                  child: _formField(
                                                      'London',
                                                      230,
                                                      18,
                                                      'assets/icons/Where.png'),
                                                ),
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
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.amber[300],
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Hotels",
                                        style: TextStyle(
                                            fontSize:
                                                size.height > divSize ? 22 : 15,
                                            color: Colors.white54,
                                            // decoration: TextDecoration.underline,
                                            letterSpacing: 1),
                                      ),
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
                                                      childAspectRatio:
                                                          0.7 / 0.2,
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
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Container(
                                                        child: Image.asset(
                                                            imageUrl[i]
                                                                .imageUrl),
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
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          "20% OFF",
                                                          style: TextStyle(
                                                              fontSize: 23,
                                                              color: Colors
                                                                  .amberAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Container(
                                                        child: Image.asset(
                                                          imageUrl[i].imageUrl,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        height: 50,
                                                        width: 50,
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      imageUrl[i].offer,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .amberAccent,
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
                                  child: ListView.builder(
                                    key: ValueKey(3),
                                    controller: _scrollController3,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (_, i) => Padding(
                                      padding: size.height > divSize
                                          ? const EdgeInsets.symmetric(
                                              vertical: 5)
                                          : const EdgeInsets.symmetric(
                                              vertical: 0),
                                      child: EaseInWidget(
                                          radius: 30,
                                          image:
                                              leftSlider[i % leftSlider.length]
                                                  .image,
                                          secondImage:
                                              leftSlider[i % leftSlider.length]
                                                  .image,
                                          onTap: () {
                                            setState(() {
                                              _hotelValue = leftSlider[
                                                      i % leftSlider.length]
                                                  .title;
                                            });
                                            print(leftSlider[
                                                    i % leftSlider.length]
                                                .image);
                                          }),
                                    ),
                                    itemCount: leftSlider.length * 100,
                                  ),
                                ),
                                // ),
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    height: size.height > divSize ? 80 : 40,
                                    width: size.height > divSize
                                        ? 680
                                        : size.width,
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
                                                image: bottomUpSlider[i %
                                                        bottomUpSlider.length]
                                                    .image,
                                                secondImage: bottomUpSlider[i %
                                                        bottomUpSlider.length]
                                                    .image,
                                                onTap: () {
                                                  print(bottomUpSlider[i %
                                                          bottomUpSlider.length]
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    height: size.height > divSize ? 80 : 40,
                                    width: size.height > divSize
                                        ? 680
                                        : size.width,
                                    child: NotificationListener<
                                        ScrollNotification>(
                                      onNotification: (notification) {
                                        if (notification
                                            is ScrollEndNotification) {
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
                                                  image: bottomDownSlider[i %
                                                          bottomDownSlider
                                                              .length]
                                                      .image,
                                                  secondImage: bottomDownSlider[
                                                          i %
                                                              bottomDownSlider
                                                                  .length]
                                                      .image,
                                                  onTap: () {
                                                    print(bottomDownSlider[i %
                                                            bottomDownSlider
                                                                .length]
                                                        .image);
                                                    _scroll();
                                                  }),
                                            ),
                                          ],
                                        ),
                                        itemCount:
                                            bottomDownSlider.length * 10000,
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

  Future<void> _showMyDialog(List<City> cityList) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: Color.fromRGBO(37, 36, 41, 1),
          content: Container(
            height: 200,
            width: 200,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cityList.length,
              itemBuilder: (context, i) => Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _location = cityList[i].cityName;
                      });
                      Navigator.of(context).pop();
                    },
                    child: ListTile(
                      title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          cityList[i].cityName,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white24,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _formField(String lable, double width, double fontSize, String image) {
    // FocusNode myFocusNode = new FocusNode();
    return Container(
      width: width,
      child: TextFormField(
        enabled: false,
        cursorColor: Colors.black,
        // focusNode: myFocusNode,
        style: TextStyle(
          color: Colors.yellow[300],
          fontSize: fontSize,
        ),

        decoration: InputDecoration(
          disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow)),
          hintText: lable == 'Hotel' ? _hotelValue : _location,
          hintStyle:
              TextStyle(color: Colors.amber, height: 1.5, fontSize: fontSize),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          ),
          prefixIcon: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 10,
              child: Image.asset(image),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
      ),
    );
  }

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
  }
}
