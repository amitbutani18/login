import 'package:flutter/material.dart';
import 'package:login/screens/contractdetails.dart';

class OwnProfile extends StatefulWidget {
  @override
  _OwnProfileState createState() => _OwnProfileState();
}

class _OwnProfileState extends State<OwnProfile> {
  var diviceSize = 470;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (BuildContext context) => ContractDetails()),
        ),
      ),
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
          Padding(
            padding: size.height > diviceSize
                ? const EdgeInsets.all(28.0)
                : const EdgeInsets.only(top: 18, right: 18, left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      iconSize: size.height > diviceSize ? 50 : 30,
                      icon: Icon(Icons.arrow_back),
                      color: Colors.amber[200],
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Own Profile",
                            style: TextStyle(
                              color: Colors.amber[200],
                              fontSize: size.height > diviceSize ? 40 : 22,
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
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: size.height > diviceSize
                            ? size.width / 2
                            : size.width / 2 - 50,
                        height: size.height > diviceSize
                            ? size.height - 150
                            : size.height - 86,
                        // color: Colors.white,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                radius: size.height > diviceSize ? 70 : 30,
                                backgroundColor: Colors.yellow,
                                backgroundImage: NetworkImage(
                                    'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                              ),
                              SizedBox(
                                height: size.height > diviceSize ? 20 : 10,
                              ),
                              Text(
                                "Akash Gajera",
                                style: TextStyle(
                                  color: Colors.amber[200],
                                  fontSize: size.height > diviceSize ? 35 : 20,
                                ),
                              ),
                              SizedBox(
                                height: size.height > diviceSize ? 30 : 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Link',
                                  style: TextStyle(
                                    color: Colors.amber[200],
                                    fontSize:
                                        size.height > diviceSize ? 25 : 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              YouLink(
                                size: size,
                                diviceSize: diviceSize,
                                heading: 'You Tube',
                                link: 'WWW.Modalhire.com',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              YouLink(
                                size: size,
                                diviceSize: diviceSize,
                                heading: 'Linkedin',
                                link: 'WWW.Modalhire.com',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              PointCredit(
                                size: size,
                                diviceSize: diviceSize,
                                heading1: "Loyalty Point",
                                value1: "70 Points",
                                heading2: "Total Earned Amount",
                                value2: "\$ 1000.00",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              PointCredit(
                                size: size,
                                diviceSize: diviceSize,
                                heading1: "SuperMe Card",
                                value1: "\$ 500.00",
                                heading2: "Credit Card",
                                value2: "**** **** **** 5821",
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: size.height > diviceSize
                              ? const EdgeInsets.symmetric(horizontal: 150)
                              : const EdgeInsets.symmetric(horizontal: 10),
                          width:
                              size.height > diviceSize ? size.width / 2 : 200,
                          height: size.height > diviceSize
                              ? size.height - 150
                              : size.height - 100,
                          // color: Colors.pink,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: size.height > diviceSize
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        color: Colors.amber[300],
                                        fontSize:
                                            size.height > diviceSize ? 25 : 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          size.height > diviceSize
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: size.height > diviceSize
                                              ? 20
                                              : 10,
                                          color: Colors.white24,
                                        ),
                                        SizedBox(
                                          width:
                                              size.height > diviceSize ? 20 : 5,
                                        ),
                                        Text(
                                          "London , Europ",
                                          style: TextStyle(
                                            color: Colors.white24,
                                            fontSize: size.height > diviceSize
                                                ? 25
                                                : 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height > diviceSize ? 30 : 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: size.height > diviceSize
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Occuption',
                                      style: TextStyle(
                                        color: Colors.amber[300],
                                        fontSize:
                                            size.height > diviceSize ? 25 : 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          size.height > diviceSize
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Fashion Model",
                                          style: TextStyle(
                                              color: Colors.white24,
                                              fontSize: size.height > diviceSize
                                                  ? 25
                                                  : 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height > diviceSize ? 50 : 10,
                                ),
                                Container(
                                  height: size.height > diviceSize ? 250 : 200,
                                  width: size.height > diviceSize
                                      ? size.width
                                      : 200,
                                  color: Colors.amber[300],
                                  child: Image.network(
                                    'https://pngimg.com/uploads/qr_code/qr_code_PNG6.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height > diviceSize ? 30 : 10,
                                ),
                                Container(
                                  height: 3,
                                  width: size.height > diviceSize
                                      ? size.width
                                      : 200,
                                  color: Colors.amber[300],
                                ),
                                SizedBox(
                                  height: size.height > diviceSize ? 30 : 10,
                                ),
                                Container(
                                  height: size.height > diviceSize ? 100 : 50,
                                  width: size.height > diviceSize
                                      ? size.width
                                      : 200,
                                  color: Colors.amber[300],
                                  child: Image.network(
                                    'https://pngimg.com/uploads/barcode/barcode_PNG34.png',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PointCredit extends StatelessWidget {
  const PointCredit({
    Key key,
    @required this.size,
    @required this.diviceSize,
    @required this.heading1,
    @required this.value1,
    @required this.heading2,
    @required this.value2,
  }) : super(key: key);

  final Size size;
  final int diviceSize;
  final String heading1;
  final String value1;
  final String heading2;
  final String value2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              heading1,
              style: TextStyle(
                color: Colors.amber[300],
                fontSize: size.height > diviceSize ? 25 : 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              value1,
              style: TextStyle(
                color: Colors.white24,
                fontSize: size.height > diviceSize ? 20 : 15,
              ),
            ),
          ],
        ),
        SizedBox(
          width: size.height > diviceSize ? 180 : 25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              heading2,
              style: TextStyle(
                color: Colors.amber[300],
                fontSize: size.height > diviceSize ? 25 : 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              value2,
              style: TextStyle(
                color: Colors.white24,
                fontSize: size.height > diviceSize ? 20 : 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class YouLink extends StatelessWidget {
  const YouLink({
    Key key,
    @required this.size,
    @required this.diviceSize,
    @required this.heading,
    @required this.link,
  }) : super(key: key);

  final Size size;
  final int diviceSize;
  final String heading;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            heading,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.height > diviceSize ? 23 : 10,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: size.width,
          height: size.height > diviceSize ? 80 : 40,
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                link,
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: size.height > diviceSize ? 23 : 10,
                ),
              ),
              FlatButton(
                onPressed: null,
                child: Text(
                  'Copy',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.amber[300],
                    fontSize: size.height > diviceSize ? 23 : 10,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
