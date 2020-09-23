import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/pagetitle.dart';
import 'package:login/helpers/constant.dart' as Constant;

class ProjectChatScreen extends StatefulWidget {
  @override
  _ProjectChatScreenState createState() => _ProjectChatScreenState();
}

class _ProjectChatScreenState extends State<ProjectChatScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int diviceSize = 470;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black54,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            PageBackground(size: size, imagePath: 'assets/background.png'),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  PageTitle(
                    diviceSize: diviceSize,
                    size: size,
                    title: 'Project A Chat',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Container(
                              // color: Colors.amber,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Group Chat',
                                    style: TextStyle(
                                      color: Constant.primaryColor,
                                      fontSize:
                                          size.height > diviceSize ? 25 : 15,
                                    ),
                                  ),
                                  GroupChatList(
                                      size: size, diviceSize: diviceSize),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Personal Chat',
                                    style: TextStyle(
                                      color: Constant.primaryColor,
                                      fontSize:
                                          size.height > diviceSize ? 25 : 15,
                                    ),
                                  ),
                                  GroupChatList(
                                      size: size, diviceSize: diviceSize),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            // color: Colors.blue,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2),
                                      ),
                                      hintText: 'Type Something Here...',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween, // added line
                                          mainAxisSize:
                                              MainAxisSize.min, // added line
                                          children: <Widget>[
                                            Icon(Icons.select_all),
                                            Icon(Icons.send),
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
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
    );
  }
}

class GroupChatList extends StatelessWidget {
  const GroupChatList({
    Key key,
    @required this.size,
    @required this.diviceSize,
  }) : super(key: key);

  final Size size;
  final int diviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 5),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, i) => Container(
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border: Border.all(color: Constant.primaryColor),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8, right: 15, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: size.height > diviceSize ? 70 : 30,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage('assets/images/profileimage.png')),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "AKASH GAJERA",
                            style: TextStyle(color: Constant.primaryColor),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Lorem Inpsim hdiss jjdfojnf ",
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat("hh-mm").format(DateTime.now()),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
        itemCount: 10,
      ),
    );
  }
}
