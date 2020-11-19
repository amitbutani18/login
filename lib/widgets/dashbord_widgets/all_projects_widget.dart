import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Constant/constant.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:login/screens/contract.dart';
import 'package:login/screens/endcontract.dart';
import 'package:login/screens/projectDetails.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:provider/provider.dart';

class AllProjectsWidget extends StatefulWidget {
  @override
  _AllProjectsWidgetState createState() => _AllProjectsWidgetState();
}

class _AllProjectsWidgetState extends State<AllProjectsWidget> {
  bool _isLoad = false;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    setState(() {
      _isLoad = true;
    });
    await Provider.of<ProjectProvider>(context, listen: false).loadAllProject();
    setState(() {
      _isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
            top: 8.0, left: width < 600 ? 0 : 30, right: width < 600 ? 0 : 10),

        // width: 450,
        // height: height / 2,
        // color: Colors.amber,
        child: _isLoad
            ? Center(child: CustomCircularProgressIndicator())
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetConstant.shared.text(
                              text: "BY ME",
                              fontSize: height > divSize ? 22 : 15,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 5,
                          ),
                          Consumer<ProjectProvider>(
                            builder: (context, projectObj, ch) => LimitedBox(
                                maxHeight: height / 2,
                                // maxWidth: 650 / 2 - 10,
                                child: projectObj.projectListByMe.length == 0
                                    ? Container(
                                        padding: EdgeInsets.all(40),
                                        child: Image.asset(
                                            'assets/images/Recore_No_Found.png'),
                                      )
                                    : ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, i) =>
                                            GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ProjectDetails(
                                                            byMeObj: projectObj
                                                                .projectListByMe[i],
                                                          ))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: CustomByMeTile(
                                              projectByMe:
                                                  projectObj.projectListByMe[i],
                                            ),
                                          ),
                                        ),
                                        itemCount:
                                            projectObj.projectListByMe.length,
                                      )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: height / 2,
                    width: 3,
                    color: Colors.amber.withOpacity(.5),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: width < 600 ? 5 : 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetConstant.shared.text(
                              text: "BY THEM",
                              fontSize: height > divSize ? 22 : 15,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 5,
                          ),
                          Consumer<ProjectProvider>(
                            builder: (context, projectobj, ch) => LimitedBox(
                                maxHeight: height / 2,
                                // maxWidth: 650 / 2 - 10,
                                child: projectobj.projectListByThem.length == 0
                                    ? Container(
                                        padding: EdgeInsets.all(40),
                                        child: Image.asset(
                                            'assets/images/Recore_No_Found.png'),
                                      )
                                    : ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, i) =>
                                            GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        EndContract(
                                                          byThemProjectObj:
                                                              projectobj
                                                                  .projectListByThem[i],
                                                        )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: CustomByThemTile(
                                              projectByThem: projectobj
                                                  .projectListByThem[i],
                                            ),
                                          ),
                                        ),
                                        itemCount:
                                            projectobj.projectListByThem.length,
                                      )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class CustomByThemTile extends StatelessWidget {
  final ByThem projectByThem;

  const CustomByThemTile({
    Key key,
    this.projectByThem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetConstant.shared.text(
              text: projectByThem.name,
              fontWeight: FontWeight.w500,
              fontSize: width < 600 ? 15 : 18
              // color: Colors.white38,
              ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                IconTitle(
                  icon: 'assets/icons/Location_icon.png',
                  title: projectByThem.where,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 1,
                  height: 10,
                  color: Colors.grey,
                ),
                IconTitle(
                  icon: 'assets/icons/Calender_icon.png',
                  title: DateFormat("dd/MM/yyyy")
                      .format(DateTime.parse(projectByThem.startDate)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomByMeTile extends StatelessWidget {
  final Byme projectByMe;

  const CustomByMeTile({
    Key key,
    @required this.projectByMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetConstant.shared.text(
            text: projectByMe.name,
            fontSize: width < 600 ? 15 : 18,
            fontWeight: FontWeight.w500,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                IconTitle(
                  icon: 'assets/icons/Location_icon.png',
                  title: projectByMe.where,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 1,
                  height: 10,
                  color: Colors.grey,
                ),
                IconTitle(
                  icon: 'assets/icons/Calender_icon.png',
                  title: DateFormat("dd/MM/yyyy")
                      .format(DateTime.parse(projectByMe.endDate)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IconTitle extends StatelessWidget {
  final String title;
  final String icon;
  const IconTitle({
    this.title,
    this.icon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 10,
          width: 10,
          child: Image.asset(icon),
        ),
        // Icon(
        //   icon,
        //   size: 10,
        //   color: Colors.white,
        // ),
        SizedBox(
          width: 3,
        ),
        GetConstant.shared.text(
            text: title,
            color: Colors.white38,
            fontSize: width < 600 ? 10 : 15,
            letterSpacing: 0),
      ],
    );
  }
}
