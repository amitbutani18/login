import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Providers/projectdetailsprovider.dart';
import 'package:login/screens/addproject.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:provider/provider.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class ProjectDetails extends StatefulWidget {
  static const routeName = 'projectDetails';
  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    final projectDetails = Provider.of<ProjectDetailsProvider>(context).project;
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
                        content: projectDetails.hotalName,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      IconAndDetailsRowForProjectDetails(
                        size: size,
                        image: 'assets/icons/Where.png',
                        content: projectDetails.location,
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
                        image: 'assets/icons/calender.png',
                        content:
                            '${DateFormat("dd-MMM").format(projectDetails.dateTime[0])} | ${DateFormat("dd-MM-yyyy").format(projectDetails.dateTime[1])}',
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      IconAndDetailsRowForProjectDetails(
                        size: size,
                        image: 'assets/icons/Dollar.png',
                        content: projectDetails.price.toString(),
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
                        content: projectDetails.website,
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
                        content: projectDetails.uses,
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
                        content: projectDetails.notes,
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

GestureDetector addMemberButton(Size size, BuildContext context) {
  return GestureDetector(
    onTap: () {
      // if (_checked) {
      // _submit();
      Navigator.pushNamed(context, AddProject.routeName);
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
