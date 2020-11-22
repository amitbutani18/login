import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Providers/membersprovider.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:login/helpers/Providers/request_provider.dart' as req;
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
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await Provider.of<MembersProvider>(context, listen: false).searchMember(
        what: widget.byMeObj.what,
        where: widget.byMeObj.where,
        members: widget.byMeObj.members);
    Provider.of<MembersProvider>(context, listen: false)
        .addMembersForoProjectDetail(widget.byMeObj.members);
  }

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
                  PageTitle(
                      size: size,
                      title: "Project Details",
                      callback: () {
                        Provider.of<MembersProvider>(context, listen: false)
                            .clearSelectedMember();
                        Navigator.of(context).pop();
                      }),
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
                        Consumer<MembersProvider>(
                          builder: (context, memberObj, ch) => Align(
                            alignment: Alignment.center,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: memberObj
                                    .memberForProjectDetailScreen.length,
                                itemBuilder: (context, i) => Text(
                                      memberObj.memberForProjectDetailScreen[i]
                                              .name +
                                          " ",
                                      style: TextStyle(
                                          fontSize:
                                              size.height > Constant.divSize
                                                  ? 22
                                                  : 15,
                                          color: Colors.white54,
                                          letterSpacing: 1),
                                    )),
                          ),
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

  _submit() async {
    Provider.of<MembersProvider>(context, listen: false)
        .getNewMember(widget.byMeObj.members);
    await Provider.of<MembersProvider>(context, listen: false)
        .addNewMemberInProject(widget.byMeObj.sId);
    Provider.of<MembersProvider>(context, listen: false).clearSelectedMember();
    Provider.of<MembersProvider>(context, listen: false).clearAddedMemberList();
    await Provider.of<req.RequestProvider>(context, listen: false)
        .loadAllProjectRequests();
    await Provider.of<ProjectProvider>(context, listen: false).loadAllProject();
    Navigator.of(context).pop();
  }

  Widget addMemberButton(Size size, BuildContext context) {
    return Consumer<MembersProvider>(
      builder: (context, membersObj, ch) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: _submit,
            child: Container(
              child: CustomCircleAvatarForIcon(
                  radius: size.height > Constant.divSize ? 40 : 30,
                  image: 'assets/icons/Acept.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(SearchMember.routeName, arguments: {
                "what": widget.byMeObj.what,
                "where": widget.byMeObj.where,
                "members": membersObj.selectedMembers.length == 0
                    ? widget.byMeObj.members
                    : List<Members>(),
              });
            },
            child: Container(
              child: CustomCircleAvatarForIcon(
                  radius: size.height > Constant.divSize ? 40 : 30,
                  image: 'assets/icons/Add_Team_Member.png'),
            ),
          ),
        ],
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
