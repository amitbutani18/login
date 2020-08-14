import 'package:flutter/material.dart';
import 'package:login/helpers/roomimageprovider.dart';
import 'package:provider/provider.dart';

class RoomDetails extends StatefulWidget {
  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  var diviceSize = 470;

  @override
  Widget build(BuildContext context) {
    final imageData = Provider.of<RoomImageProvider>(context).items;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: Container(
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.amberAccent]),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blue,
            child: SizedBox(
              width: size.height > diviceSize ? 80 : 50,
              height: size.height > diviceSize ? 80 : 50,
              child: Icon(
                Icons.payment,
                size: size.height > diviceSize ? 40 : 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/add-project');
            },
          ),
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
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
                              "Details",
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
                  Row(
                    children: <Widget>[
                      Text(
                        "OYO ROOMS | ",
                        style: TextStyle(
                            color: Colors.amber[300],
                            fontSize: size.height > diviceSize ? 35 : 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                      ),
                      Container(
                        height: 30,
                        width: 100,
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/OYO_Rooms_%28logo%29.png/1200px-OYO_Rooms_%28logo%29.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "ORGANISATION",
                    style: TextStyle(
                      color: Colors.amber[300],
                      fontSize: size.height > diviceSize ? 30 : 20,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: size.height > diviceSize ? 15 : 10,
                  ),
                  Text(
                    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful conten used to demonstrate the visual.",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: size.height > diviceSize ? 25 : 15,
                        letterSpacing: 1.2),
                  ),
                  SizedBox(
                    height: size.height > diviceSize ? 30 : 20,
                  ),
                  Text(
                    "DISCOUNT",
                    style: TextStyle(
                      color: Colors.amber[300],
                      fontSize: size.height > diviceSize ? 30 : 20,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: size.height > diviceSize ? 15 : 10,
                  ),
                  Text(
                    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful conten used to demonstrate the visual.",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: size.height > diviceSize ? 25 : 15,
                        letterSpacing: 1.2),
                  ),
                  SizedBox(
                    height: size.height > diviceSize ? 30 : 20,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          height: size.height > diviceSize ? 300 : 170,
                          width: size.height > diviceSize ? 800 : 600,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, i) => Padding(
                              padding: size.height > diviceSize
                                  ? const EdgeInsets.all(28.0)
                                  : const EdgeInsets.all(8.0),
                              child: Container(
                                height: size.height > diviceSize ? 300 : 170,
                                width: size.height > diviceSize ? 200 : 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    imageData[i].imageUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          )),
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
