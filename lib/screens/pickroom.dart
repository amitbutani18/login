import 'package:flutter/material.dart';
import 'package:login/helpers/iconprovider.dart';
import 'package:login/helpers/imageprovider.dart';
import 'package:login/helpers/tabiconprovider.dart';
import 'package:login/widgets/datepick.dart';
import 'package:login/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class PickRoom extends StatefulWidget {
  @override
  _PickRoomState createState() => _PickRoomState();
}

class _PickRoomState extends State<PickRoom> {
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();

  double divSize = 470;

  int speedFactor = 20;
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
    double maxExtent3 = _scrollController.position.maxScrollExtent;
    double distanceDifference3 = maxExtent - _scrollController.offset;
    double durationDouble3 = distanceDifference2 / speedFactor;
    print(maxExtent3);
    _scrollController3.animateTo(maxExtent3,
        duration: Duration(seconds: durationDouble3.toInt()),
        curve: Curves.linear);
  }

  Widget _formField(String lable, double width, double fontSize) {
    // FocusNode myFocusNode = new FocusNode();
    return Container(
      width: width,
      child: TextFormField(
        // focusNode: myFocusNode,
        style: TextStyle(color: Colors.yellow[300]),

        decoration: InputDecoration(
          hintText: lable,
          hintStyle:
              TextStyle(color: Colors.grey, height: 1.5, fontSize: fontSize),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
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
                        child: Icon(
                      lable == 'London'
                          ? Icons.location_on
                          : lable == 'Date'
                              ? Icons.date_range
                              : Icons.help_outline,
                      color: Colors.black87,
                      size: fontSize == 30 ? 30 : 20,
                    ))),
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
  Widget build(BuildContext context) {
    final productData = Provider.of<IconProvider>(context);
    final icon = productData.items;
    final tabIconData = Provider.of<TabIconProvider>(context);
    final tabIcon = tabIconData.items;
    final imageData = Provider.of<ImagesProvider>(context);
    final imageUrl = imageData.items;
    Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scroll());
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
                          child: IconButton(
                            iconSize: size.height > divSize ? 50 : 30,
                            icon: Icon(Icons.menu),
                            color: Colors.amber[200],
                            onPressed: () {},
                          ),
                        ),
                        size.height > divSize
                            ? Container()
                            : Center(
                                child: Container(
                                  height: 50,
                                  width: 300,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, i) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: RoundedButton(
                                        onTap: () {
                                          print(icon[i].icon.icon);
                                        },
                                        iconData: size.height > divSize
                                            ? tabIcon[i].icon
                                            : icon[i].icon,
                                        radius: 30,
                                      ),
                                    ),
                                    itemCount: icon.length,
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
                          child: IconButton(
                            iconSize: size.height > divSize ? 50 : 30,
                            icon: Icon(Icons.home),
                            color: Colors.amber[200],
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  size.height > divSize
                      ? Center(
                          child: Container(
                            height: size.height > divSize ? 60 : 30,
                            width: size.height > divSize ? 550 : 300,
                            child: ListView.builder(
                              controller: _scrollController3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, i) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: ClipOval(
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(50.0)),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: Colors.blue,
                                        child: SizedBox(
                                          width:
                                              size.height > divSize ? 60 : 30,
                                          height: 30,
                                          child: ShaderMask(
                                            shaderCallback: (bounds) =>
                                                RadialGradient(
                                              colors: [
                                                Colors.white,
                                                Colors.yellow[400],
                                                Colors.white
                                              ],
                                            ).createShader(bounds),
                                            child: size.height > divSize
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
                              itemCount: icon.length,
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
                            height: size.height > divSize ? 400 : 200,
                            width: size.height > divSize ? 80 : 60,
                            child: ListView.builder(
                              itemBuilder: (_, i) => Padding(
                                padding: size.height > divSize
                                    ? const EdgeInsets.symmetric(vertical: 5)
                                    : const EdgeInsets.symmetric(vertical: 0),
                                child: RoundedButton(
                                  onTap: () {
                                    print(icon[i].icon.icon);
                                  },
                                  iconData: size.height > divSize
                                      ? tabIcon[i].icon
                                      : icon[i].icon,
                                  radius: size.height > divSize ? 50 : 30,
                                ),
                              ),
                              itemCount: icon.length,
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
                                    ? _formField('Hotel', 650, 30)
                                    : _formField('Hotel', 450, 18),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: size.height > divSize
                                        ? _formField('London', 350, 30)
                                        : _formField('London', 250, 18),
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
                                        controller: _scrollController3,
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
                                                  color: Colors.white,
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
                                        controller: _scrollController3,
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
                            height: size.height > divSize ? 400 : 200,
                            width: size.height > divSize ? 80 : 60,
                            child: ListView.builder(
                              itemBuilder: (_, i) => Padding(
                                padding: size.height > divSize
                                    ? const EdgeInsets.symmetric(vertical: 5)
                                    : const EdgeInsets.symmetric(vertical: 0),
                                child: RoundedButton(
                                  onTap: () {
                                    print(icon[i].icon.icon);
                                  },
                                  iconData: size.height > divSize
                                      ? tabIcon[i].icon
                                      : icon[i].icon,
                                  radius: size.height > divSize ? 50 : 30,
                                ),
                              ),
                              itemCount: icon.length,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: size.height > divSize
                            ? const EdgeInsets.only(top: 480.0)
                            : const EdgeInsets.only(top: 240.0),
                        child: Center(
                          child: Container(
                            height: size.height > divSize ? 80 : 40,
                            width: size.height > divSize ? 680 : 400,
                            child: ListView.builder(
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
                                    child: RoundedButton(
                                      onTap: () {
                                        print(icon[i].icon.icon);
                                      },
                                      iconData: size.height > divSize
                                          ? tabIcon[i].icon
                                          : icon[i].icon,
                                      radius: size.height > divSize ? 40 : 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: size.height > divSize
                                        ? const EdgeInsets.only(
                                            top: 45.0, left: 65)
                                        : const EdgeInsets.only(
                                            top: 22.0, left: 34),
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
                                              width: size.height > divSize
                                                  ? 25
                                                  : 12,
                                              height: size.height > divSize
                                                  ? 25
                                                  : 12,
                                              child: Center(
                                                child: Text(
                                                  '20%',
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.height > divSize
                                                              ? 13
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
                        ),
                      ),
                      Padding(
                        padding: size.height > divSize
                            ? const EdgeInsets.only(top: 570.0)
                            : const EdgeInsets.only(top: 280.0),
                        child: Center(
                          child: Container(
                            height: size.height > divSize ? 80 : 40,
                            width: size.height > divSize ? 680 : 400,
                            child: ListView.builder(
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
                                    child: RoundedButton(
                                      onTap: () {
                                        print(icon[i].icon.icon);
                                      },
                                      iconData: size.height > divSize
                                          ? tabIcon[i].icon
                                          : icon[i].icon,
                                      radius: size.height > divSize ? 40 : 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: size.height > divSize
                                        ? const EdgeInsets.only(
                                            top: 45.0, left: 65)
                                        : const EdgeInsets.only(
                                            top: 22.0, left: 34),
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
                                              width: size.height > divSize
                                                  ? 25
                                                  : 12,
                                              height: size.height > divSize
                                                  ? 25
                                                  : 12,
                                              child: Center(
                                                child: Text(
                                                  '20%',
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.height > divSize
                                                              ? 13
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
}
