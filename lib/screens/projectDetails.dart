import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:login/helpers/Providers/projectdetailsprovider.dart';
import 'package:login/screens/addproject.dart';
import 'package:login/screens/searchmember.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:provider/provider.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class ProjectDetails extends StatefulWidget {
  static const routeName = 'projectDetails';
  final Byme byMeObj;

  ProjectDetails({
    this.byMeObj,
  });
  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // key: _scaffoldKey,
      floatingActionButton:
          Builder(builder: (context) => addMemberButton(size, context)),
      body: Stack(
        children: <Widget>[
          PageBackground(
              size: size,
              imagePath: 'assets/images/projectDetailBackground.png'),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PageTitle(size: size, title: "Project Details"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconAndDetailsRowForProjectDetails(
                        size: size,
                        image: 'assets/icons/What.png',
                        content: widget.byMeObj.name,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconAndDetailsRowForProjectDetails(
                        size: size,
                        image: 'assets/icons/What.png',
                        content: widget.byMeObj.what,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      IconAndDetailsRowForProjectDetails(
                        size: size,
                        image: 'assets/icons/Where.png',
                        content: widget.byMeObj.where,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconAndDetailsRowForProjectDetails(
                        size: size,
                        image: 'assets/icons/Calender.png',
                        content:
                            '${DateFormat("dd-MMM").format(DateTime.parse(widget.byMeObj.startDate))} | ${DateFormat("dd-MM-yyyy").format(DateTime.parse(widget.byMeObj.endDate))}',
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      IconAndDetailsRowForProjectDetails(
                        size: size,
                        image: 'assets/icons/Dollar.png',
                        content: widget.byMeObj.price.toString(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconAndDetailsRowForProjectDetails(
                        size: size,
                        image: 'assets/icons/Lickicon.png',
                        content: widget.byMeObj.link,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconAndDetailsRowForProjectDetails(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        size: size,
                        image: 'assets/icons/Usages.png',
                        content: widget.byMeObj.usages,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconAndDetailsRowForProjectDetails(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        size: size,
                        image: 'assets/icons/Notes.png',
                        content: widget.byMeObj.notes,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: size.width,
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        Container(
                          // padding: EdgeInsets.all(8),
                          // margin: EdgeInsets.only(right: 0),
                          child: CustomCircleAvatarForIcon(
                            image: 'assets/icons/Afflicated.png',
                            radius: 15.0,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.byMeObj.members.length,
                              itemBuilder: (context, i) => Text(
                                    widget.byMeObj.members[i].sId,
                                    style: TextStyle(
                                        fontSize: size.height > Constant.divSize
                                            ? 22
                                            : 15,
                                        color: Colors.white54,
                                        letterSpacing: 1),
                                  )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector addMemberButton(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (_checked) {

        // _submit();
        Navigator.of(context).pushNamed(SearchMember.routeName, arguments: {
          "what": widget.byMeObj.what,
          "where": widget.byMeObj.where,
          "members": widget.byMeObj.members
        });
        // Navigator.pop(context, true);
        // } else {
        //   CustomSnackBar(context, "Please agree SUPREME card policy",
        //       SnackBartype.nagetive);
        // }
      },
      child: Container(
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: size.height > Constant.divSize ? 40 : 30,
            child: Image.asset('assets/icons/Add_Team_Member.png')),
      ),
    );
  }
}

class IconAndDetailsRowForProjectDetails extends StatelessWidget {
  final String image, content;
  final CrossAxisAlignment crossAxisAlignment;

  const IconAndDetailsRowForProjectDetails({
    Key key,
    @required this.size,
    @required this.image,
    @required this.content,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // padding: EdgeInsets.all(8),
            // margin: EdgeInsets.only(right: 0),
            child: CustomCircleAvatarForIcon(
              image: image,
              radius: 15.0,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                  fontSize: size.height > Constant.divSize ? 22 : 15,
                  color: Colors.white54,
                  letterSpacing: 1),
            ),
          )
        ],
      ),
    );
  }
}
