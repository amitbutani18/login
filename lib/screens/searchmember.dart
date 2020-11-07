import 'package:flutter/material.dart';
import 'package:login/helpers/Providers/membersprovider.dart';
import 'package:login/screens/projectDetails.dart';
import 'package:login/screens/teammate_profile_screen.dart';
import 'package:login/screens/teammateprofile.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/dashbord_widgets/all_request_widget.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:provider/provider.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class SearchMember extends StatefulWidget {
  static const routeName = '/searchMember';
  @override
  _SearchMemberState createState() => _SearchMemberState();
}

class _SearchMemberState extends State<SearchMember> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final memberData = Provider.of<MembersProvider>(context).items;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageBackground(size: size, imagePath: 'assets/background.png'),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PageTitle(size: size, title: "Search Member"),
                  SizedBox(
                    height: 20,
                  ),
                  _formField(
                    lable: 'Search Member',
                    width: size.width,
                    fontSize: 15,
                    image: 'assets/icons/What.png',
                    textInputType: TextInputType.text,
                    controller: _searchController,
                    maxLine: 1,
                  ),
                  SizedBox(
                    height: size.height > Constant.divSize ? 40 : 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      width: size.width / 1.5,
                      child: Row(
                        children: <Widget>[
                          IconAndDetailsRowForProjectDetails(
                            size: size,
                            image: 'assets/icons/What.png',
                            content: "Fashion Model",
                          ),
                          SizedBox(
                            width: size.height > Constant.divSize ? 20 : 0,
                          ),
                          Container(
                            height: 30.0,
                            width: 2.0,
                            color: Constant.primaryColor,
                            margin:
                                const EdgeInsets.only(left: 0.0, right: 10.0),
                          ),
                          IconAndDetailsRowForProjectDetails(
                            size: size,
                            image: 'assets/icons/Where.png',
                            content: "London",
                          ),
                          Container(
                            height: 30.0,
                            width: 2.0,
                            color: Constant.primaryColor,
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                          IconAndDetailsRowForProjectDetails(
                            size: size,
                            image: 'assets/icons/Calender.png',
                            content: "Fashion Model",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height > Constant.divSize ? 30 : 10,
                  ),
                  SearchResultTitle(
                    size: size,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: size.height > Constant.divSize ? size.width : 700,
                    height: size.height > Constant.divSize ? 450 : 150,
                    alignment: Alignment.topLeft,
                    color: Colors.transparent,
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: memberData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // maxCrossAxisExtent: 200,
                          childAspectRatio: 1 / 0.43,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 3),
                      itemBuilder: (_, i) => GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TeamMateProfileScreen(
                                      memberData: memberData[i],
                                    ))),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      memberData[i].name,
                                      style: TextStyle(
                                        color: Constant.primaryColor,
                                        fontSize: size.height > Constant.divSize
                                            ? 35
                                            : 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  IconTitle(
                                    icon: 'assets/icons/Location_icon.png',
                                    title: memberData[i].location,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  IconTitle(
                                    icon: 'assets/icons/Location_icon.png',
                                    title: memberData[i].amount.toString(),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formField({
    String lable,
    double width,
    double fontSize,
    String image,
    TextInputType textInputType,
    TextEditingController controller,
    int maxLine,
    bool enable = true,
  }) {
    return Container(
      width: width,
      child: TextField(
          controller: controller,
          keyboardType: textInputType,
          maxLines: maxLine,
          textInputAction: TextInputAction.done,
          enabled: enable,
          onChanged: (val) {
            print(val);
          },
          // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          style: TextStyle(color: Constant.primaryColor, fontSize: fontSize),
          decoration: CustomInputDecoration.customInputDecoration(
                  lable, fontSize, image)
              .copyWith(
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Constant.primaryColor)),
          )),
    );
  }
}

class SearchResultTitle extends StatelessWidget {
  const SearchResultTitle({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Constant.primaryColor,
          ),
        ),
      ),
      child: Text(
        "Search Result",
        style: TextStyle(
            fontSize: size.height > Constant.divSize ? 22 : 15,
            color: Colors.white54,
            letterSpacing: 1),
      ),
    );
  }
}

class IconAndName extends StatelessWidget {
  const IconAndName({
    Key key,
    @required this.size,
    @required this.icon,
    @required this.name,
  }) : super(key: key);

  final Size size;

  final String name;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          icon,
          SizedBox(
            width: size.height > Constant.divSize ? 15 : 5,
          ),
          Text(
            name,
            style: TextStyle(
              color: Colors.white54,
              fontSize: size.height > Constant.divSize ? 25 : 10,
            ),
          ),
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key key, @required this.size, @required this.icon})
      : super(key: key);

  final Size size;

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
                Constant.primaryColor,
              ]),
          borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
        ),
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: size.height > Constant.divSize ? 60 : 30,
            height: size.height > Constant.divSize ? 60 : 30,
            child: Center(
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
