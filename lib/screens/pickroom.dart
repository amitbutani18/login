import 'package:flutter/material.dart';
import 'package:login/helpers/citylist.dart';
import 'package:login/helpers/imageprovider.dart';
import 'package:login/helpers/slider/bottomdownsliderprovider.dart';
import 'package:login/helpers/slider/bottomupsliderprovider.dart';
import 'package:login/helpers/slider/leftsideslidericonprovider.dart';
import 'package:login/helpers/slider/rightsidesliderprovider.dart';
import 'package:login/helpers/slider/slidericon.dart';
import 'package:login/helpers/slider/topslidericonprovider.dart';
import 'package:login/widgets/bottomfirstslider.dart';
import 'package:login/widgets/bottomsecslider.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/dashbord_widgets/dashborddrawer.dart';
import 'package:login/widgets/dashbord_widgets/topsliderformobile.dart';
import 'package:login/widgets/dashbord_widgets/topsliderfortab.dart';
import 'package:login/widgets/datepick.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:login/helpers/constant.dart' as Constant;

class PickRoom extends StatefulWidget {
  static const routeName = '/dashbord';
  @override
  _PickRoomState createState() => _PickRoomState();
}

class _PickRoomState extends State<PickRoom> {
  ScrollController _scrollController;
  ScrollController _scrollController2;
  FixedExtentScrollController _scrollController3;
  FixedExtentScrollController _scrollController4;
  ScrollController _scrollController5;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  double oldValue = 0;
  String _hotelValue;
  String _location;
  var _isInit = true;
  var _isLoading = false;

  bool _whatSelect = false;
  bool _whereSelect = false;

  List<DateTime> dateList;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = FixedExtentScrollController();
    _scrollController4 = FixedExtentScrollController();
    _scrollController5 = ScrollController();

    _scrollController3.addListener(() async {
      controllerListener(_scrollController3);
    });
    _scrollController4.addListener(() async {
      controllerListener(_scrollController4);
    });
    _scrollController5.addListener(() async {
      controllerListener(_scrollController5);
    });
  }

  controllerListener(ScrollController controller) {
    var distance = oldValue - controller.position.pixels;
    // print("controller.position.pixels " + controller.position.pixels.toString());
    if (distance > 50 || distance < -50) {
      print("distance");
      print(distance);
      HapticFeedback.lightImpact();
      oldValue = controller.position.pixels;
    }
    if (controller.position.atEdge) {
      if (controller.position.pixels == 0) {
        // you are at top position
        print("top");
      } else {
        // you are at bottom position
        print("bottom");
      }
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      try {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<RightSideSliderIconProvider>(context, listen: false)
            .setIcon();
        await Provider.of<LeftSideSliderIconProvider>(context, listen: false)
            .setIcon();
        await Provider.of<BottomUpSliderProvider>(context, listen: false)
            .setIcon();
        await Provider.of<BottomDownSliderProvider>(context, listen: false)
            .setIcon();
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
      }
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    _scrollController4.dispose();
    _scrollController5.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageData = Provider.of<ImagesProvider>(context);
    final imageUrl = imageData.items;
    final sliderIconData = Provider.of<TopSliderIconProvider>(context);
    final slider = sliderIconData.items;
    // final topSecSlider = sliderIconData.images;
    final leftIconData = Provider.of<LeftSideSliderIconProvider>(context);
    final leftSlider = leftIconData.items;
    final rightIconData = Provider.of<RightSideSliderIconProvider>(context);
    final rightSlider = rightIconData.items;
    final cityList = Provider.of<CityList>(context).items;
    Size size = MediaQuery.of(context).size;

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
      body: Stack(
        children: <Widget>[
          PageBackground(size: size, imagePath: 'assets/background.png'),
          _isLoading
              ? CustomCircularProgressIndicator()
              : Container(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 18.0, left: 18, right: 18),
                            child: dashbordAppBar(size, slider, context),
                          ),
                        ),
                        size.height > Constant.divSize
                            ? TopSliderForTab(size: size, slider: slider)
                            : Container(),
                        size.height > Constant.divSize
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              //LeftSlider
                              leftRightSericesSlider(
                                size,
                                _scrollController4,
                                rightSlider,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //Services
                                  Padding(
                                    padding: size.height > Constant.divSize
                                        ? const EdgeInsets.only(top: 48.0)
                                        : const EdgeInsets.only(top: 18.0),
                                    child: size.height > Constant.divSize
                                        ? _formField('What', 650, 30,
                                            'assets/icons/What.png')
                                        : _formField('What', 450, 18,
                                            'assets/icons/What.png'),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      //CityList
                                      !_whatSelect
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0),
                                              child: size.height >
                                                      Constant.divSize
                                                  ? _formField('Where', 350, 30,
                                                      'assets/icons/Where.png')
                                                  : FutureBuilder(
                                                      future:
                                                          Provider.of<CityList>(
                                                                  context)
                                                              .fetchCity(),
                                                      builder:
                                                          (context, snap) =>
                                                              GestureDetector(
                                                        onTap: () =>
                                                            _showMyDialog(
                                                                cityList),
                                                        child: _formField(
                                                            'Where',
                                                            230,
                                                            18,
                                                            'assets/icons/Where.png'),
                                                      ),
                                                    ),
                                            ),
                                      SizedBox(
                                        width: 20,
                                      ),

                                      //DatePicker
                                      !_whereSelect
                                          ? Container(
                                              height: 65,
                                            )
                                          : DatePick(
                                              hotel: _hotelValue,
                                              city: _location,
                                            ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height > Constant.divSize
                                        ? 30
                                        : 10,
                                  ),
                                  //Hotel Title
                                  HotelTitle(size: size),

                                  //HotelsList
                                  size.height > Constant.divSize
                                      ? hotelsListForTab(imageUrl)
                                      : hotelsListForMobile(imageUrl),
                                ],
                              ),

                              //RightSlider
                              leftRightSericesSlider(
                                size,
                                _scrollController3,
                                leftSlider,
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: BottomFirstSlider(
                              size: size,
                              boxSize: 40.0,
                              controller: _scrollController,
                              isLoading: _isLoading,
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: BottomSecSlider(
                              size: size,
                              boxSize: 40.0,
                              controller: _scrollController2,
                              isLoading: _isLoading,
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

  Row dashbordAppBar(Size size, List<SliderIcon> slider, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print("hello");
            _scaffoldKey.currentState.openDrawer();
          },
          child: CircleAvatar(
            radius: size.height > Constant.divSize ? 20 : 10,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/icons/Sidebar.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        size.height > Constant.divSize
            ? Container()
            : TopSliderForMobile(
                scrollController5: _scrollController5, slider: slider),
        GestureDetector(
          // onTap: () =>
          //     Navigator.of(context).pushNamed(ServiceProvider.routeName),
          child: CircleAvatar(
            radius: size.height > Constant.divSize ? 20 : 10,
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

  Widget leftRightSericesSlider(
      Size size, ScrollController controller, List<SliderIcon> serviceList) {
    return Container(
      height: size.height > Constant.divSize ? 480 : 200,
      width: size.height > Constant.divSize ? 80 : 60,
      child: ListWheelScrollView.useDelegate(
        overAndUnderCenterOpacity: 0.7,
        magnification: 1.2,
        useMagnifier: true,
        itemExtent: 50,
        physics: FixedExtentScrollPhysics(),
        controller: controller,
        onSelectedItemChanged: (value) {
          print("onSelectedItemChanged" + value.toString());
          setState(() {
            _hotelValue = serviceList[value].title;
          });
          _whatSelect = true;
        },
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List<Widget>.generate(
            serviceList.length,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  serviceList[i].image,
                ),
              ),
            ),
          ),
        ),
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
                        _whereSelect = true;
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
    return Container(
      width: width,
      child: TextFormField(
        enabled: false,
        cursorColor: Colors.black,
        style: TextStyle(
          color: Constant.primaryColor,
          fontSize: fontSize,
        ),
        decoration: InputDecoration(
          disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Constant.primaryColor)),
          hintText: lable == 'What'
              ? _hotelValue == null ? 'What' : _hotelValue
              : _location == null ? 'Where' : _location,
          hintStyle: TextStyle(
              color: Constant.primaryColor, height: 1.5, fontSize: fontSize),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Constant.primaryColor),
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
            borderSide: BorderSide(color: Constant.primaryColor),
          ),
        ),
      ),
    );
  }

  Container hotelsListForMobile(List<Images> imageUrl) {
    return Container(
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
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  child: Image.asset(
                    imageUrl[i].imageUrl,
                    fit: BoxFit.fill,
                  ),
                  height: 50,
                  width: 50,
                  color: Colors.transparent,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                imageUrl[i].offer,
                style: TextStyle(
                    color: Constant.primaryColor, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container hotelsListForTab(List<Images> imageUrl) {
    return Container(
      width: 700,
      height: 200,
      color: Colors.transparent,
      child: GridView.builder(
        itemCount: imageUrl.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // maxCrossAxisExtent: 200,
            childAspectRatio: 0.7 / 0.2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3),
        itemBuilder: (_, i) => Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  child: Image.asset(imageUrl[i].imageUrl),
                  height: 70,
                  width: 70,
                  color: Colors.grey[850],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "20% OFF",
                    style: TextStyle(
                        fontSize: 23,
                        color: Constant.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HotelTitle extends StatelessWidget {
  const HotelTitle({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Constant.primaryColor,
          ),
        ),
      ),
      child: Text(
        "Hotels",
        style: TextStyle(
            fontSize: size.height > Constant.divSize ? 22 : 15,
            color: Colors.white54,
            letterSpacing: 1),
      ),
    );
  }
}
