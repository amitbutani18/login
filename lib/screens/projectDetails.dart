import 'package:flutter/material.dart';

class ProjectDetails extends StatelessWidget {
  var diviceSize = 470;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: ClipOval(
        child: Container(
          decoration: new BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.amberAccent]),
            borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.blue,
              child: SizedBox(
                  width: size.height > diviceSize ? 80 : 50,
                  height: size.height > diviceSize ? 80 : 50,
                  child: Icon(
                    Icons.add,
                    size: size.height > diviceSize ? 40 : 20,
                  )),
              onTap: () {
                Navigator.of(context).pushNamed('/search-member');
              },
            ),
          ),
        ),
      ),
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
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
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
                              "Project Details",
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
                  Padding(
                    padding: size.height > diviceSize
                        ? const EdgeInsets.all(18.0)
                        : const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: size.width / 2,
                          child: Row(
                            children: <Widget>[
                              Logo(
                                size: size,
                                diviceSize: diviceSize,
                                icon: Icon(
                                  Icons.help,
                                  color: Colors.black87,
                                  size: size.height > diviceSize ? 30 : 18,
                                ),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Text(
                                "Hotel",
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize:
                                        size.height > diviceSize ? 25 : 18),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Logo(
                              size: size,
                              diviceSize: diviceSize,
                              icon: Icon(
                                Icons.location_on,
                                color: Colors.black87,
                                size: size.height > diviceSize ? 30 : 18,
                              ),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            Text(
                              "Mumbai",
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: size.height > diviceSize ? 25 : 18),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: size.height > diviceSize
                        ? const EdgeInsets.all(18.0)
                        : const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: size.width / 2,
                          child: Row(
                            children: <Widget>[
                              Logo(
                                size: size,
                                diviceSize: diviceSize,
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black87,
                                  size: size.height > diviceSize ? 30 : 18,
                                ),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Text(
                                "20 - Jul | 1 - Aug - 2020",
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize:
                                        size.height > diviceSize ? 25 : 18),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Logo(
                              size: size,
                              diviceSize: diviceSize,
                              icon: Icon(
                                Icons.attach_money,
                                color: Colors.black87,
                                size: size.height > diviceSize ? 30 : 18,
                              ),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            Text(
                              "\$ 250",
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: size.height > diviceSize ? 25 : 18),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: size.height > diviceSize
                        ? const EdgeInsets.all(18.0)
                        : const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: size.height > diviceSize ? 900 : 700,
                          child: Row(
                            children: <Widget>[
                              Logo(
                                size: size,
                                diviceSize: diviceSize,
                                icon: Icon(
                                  Icons.portrait,
                                  color: Colors.black87,
                                  size: size.height > diviceSize ? 30 : 18,
                                ),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Text(
                                "Smit S. William , Akash Gajera , Kapil Maheshvari",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: size.height > diviceSize ? 25 : 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: size.height > diviceSize
                        ? const EdgeInsets.all(18.0)
                        : const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: size.height > diviceSize ? 900 : 700,
                          child: Row(
                            children: <Widget>[
                              Logo(
                                size: size,
                                diviceSize: diviceSize,
                                icon: Icon(
                                  Icons.link,
                                  color: Colors.black87,
                                  size: size.height > diviceSize ? 30 : 18,
                                ),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Text(
                                "WWW.SUPERMECARD.COM",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: size.height > diviceSize ? 25 : 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: size.height > diviceSize
                        ? const EdgeInsets.all(18.0)
                        : const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Logo(
                                size: size,
                                diviceSize: diviceSize,
                                icon: Icon(
                                  Icons.map,
                                  color: Colors.black87,
                                  size: size.height > diviceSize ? 30 : 18,
                                ),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Container(
                                width: size.width - 200,
                                height: 150,
                                child: Expanded(
                                  child: Text(
                                    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful contentIn publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content",
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize:
                                            size.height > diviceSize ? 25 : 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: size.height > diviceSize
                        ? const EdgeInsets.all(18.0)
                        : const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Logo(
                                size: size,
                                diviceSize: diviceSize,
                                icon: Icon(
                                  Icons.bookmark_border,
                                  color: Colors.black87,
                                  size: size.height > diviceSize ? 30 : 18,
                                ),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Container(
                                width: size.width - 200,
                                height: 150,
                                child: Expanded(
                                  child: Text(
                                    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful contentIn publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content",
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize:
                                            size.height > diviceSize ? 25 : 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
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

class Logo extends StatelessWidget {
  const Logo(
      {Key key,
      @required this.size,
      @required this.diviceSize,
      @required this.icon})
      : super(key: key);

  final Size size;
  final int diviceSize;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
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
            width: size.height > diviceSize ? 50 : 30,
            height: size.height > diviceSize ? 50 : 30,
            child: Center(
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
