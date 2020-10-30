import 'package:flutter/material.dart';
import 'package:login/helpers/Providers/roomdetailsprovider.dart';
import 'package:login/helpers/Providers/roomimageprovider.dart';
import 'package:login/screens/addproject.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:provider/provider.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class RoomDetails extends StatefulWidget {
  static const routeName = '/roomDetails';
  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  Widget build(BuildContext context) {
    final imageData = Provider.of<RoomImageProvider>(context).items;
    final roomDetails = Provider.of<RoomDetailsProvider>(context);
    final detailsData = roomDetails.items;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: Container(
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Constant.primaryColor]),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blue,
            child: SizedBox(
              width: size.height > Constant.divSize ? 80 : 50,
              height: size.height > Constant.divSize ? 80 : 50,
              child: Icon(
                Icons.payment,
                size: size.height > Constant.divSize ? 40 : 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AddProject.routeName);
            },
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          PageBackground(size: size, imagePath: 'assets/background.png'),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PageTitle(size: size, title: "Details"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        detailsData[0].title + " | ",
                        style: TextStyle(
                            color: Constant.primaryColor,
                            fontSize: size.height > Constant.divSize ? 35 : 22,
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
                      color: Constant.primaryColor,
                      fontSize: size.height > Constant.divSize ? 30 : 20,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: size.height > Constant.divSize ? 15 : 10,
                  ),
                  Text(
                    detailsData[0].organisationDetails,
                    // "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful conten used to demonstrate the visual.",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: size.height > Constant.divSize ? 25 : 15,
                        letterSpacing: 1.2),
                  ),
                  SizedBox(
                    height: size.height > Constant.divSize ? 30 : 20,
                  ),
                  Text(
                    "DISCOUNT",
                    style: TextStyle(
                      color: Constant.primaryColor,
                      fontSize: size.height > Constant.divSize ? 30 : 20,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: size.height > Constant.divSize ? 15 : 10,
                  ),
                  Text(
                    detailsData[0].discountDetails,
                    // "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful conten used to demonstrate the visual.",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: size.height > Constant.divSize ? 25 : 15,
                        letterSpacing: 1.2),
                  ),
                  SizedBox(
                    height: size.height > Constant.divSize ? 30 : 20,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          height: size.height > Constant.divSize ? 300 : 170,
                          width: size.height > Constant.divSize ? 800 : 600,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, i) => Padding(
                              padding: size.height > Constant.divSize
                                  ? const EdgeInsets.all(28.0)
                                  : const EdgeInsets.all(8.0),
                              child: Container(
                                height:
                                    size.height > Constant.divSize ? 300 : 170,
                                width:
                                    size.height > Constant.divSize ? 200 : 120,
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
