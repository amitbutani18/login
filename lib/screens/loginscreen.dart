import 'package:flutter/material.dart';
import 'package:login/helpers/iconprovider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<IconProvider>(context);
    final icon = productData.items;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  // color: Colors.red,
                  height: 40,
                  width: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipOval(
                        child: Material(
                          color: Colors.yellow, // button color
                          child: InkWell(
                            splashColor: Colors.blue, // inkwell color
                            child: SizedBox(
                                width: 40, height: 40, child: icon[i].icon),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    itemCount: icon.length,
                    // children: list,
                  ),
                ),
              ),
              Container(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 40,
                      child: ListView.builder(
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ClipOval(
                            child: Material(
                              color: Colors.yellow, // button color
                              child: InkWell(
                                splashColor: Colors.blue, // inkwell color
                                child: SizedBox(
                                    width: 40, height: 40, child: icon[i].icon),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ),
                        itemCount: icon.length,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amberAccent),
                              ),
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.red)),
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amberAccent),
                              ),
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.red)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      width: 40,
                      child: ListView.builder(
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ClipOval(
                            child: Material(
                              color: Colors.yellow, // button color
                              child: InkWell(
                                splashColor: Colors.blue, // inkwell color
                                child: SizedBox(
                                    width: 40, height: 40, child: icon[i].icon),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ),
                        itemCount: icon.length,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Container(
                    // color: Colors.red,
                    height: 40,
                    width: 500,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ClipOval(
                          child: Material(
                            color: Colors.yellow, // button color
                            child: InkWell(
                              splashColor: Colors.blue, // inkwell color
                              child: SizedBox(
                                  width: 40, height: 40, child: icon[i].icon),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                      itemCount: icon.length,
                      // children: list,
                    ),
                  ),
                ),
              ),
              Container(
                width: 500,
                // color: Colors.red,
                child: CarouselSlider.builder(
                  itemCount: icon.length,
                  itemBuilder: (BuildContext context, int itemIndex) =>
                      Container(
                    height: 40,
                    width: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ClipOval(
                        child: Material(
                          color: Colors.yellow, // button color
                          child: InkWell(
                            splashColor: Colors.blue, // inkwell color
                            child: SizedBox(
                                width: 40,
                                height: 40,
                                child: icon[itemIndex].icon),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                      height: 50,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 1 / 1,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(microseconds: 100),
                      viewportFraction: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
