import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Constant/providers_list.dart';
import 'package:login/helpers/Providers/membersprovider.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:login/helpers/citylist.dart';
import 'package:login/helpers/dashboard_method.dart';
import 'package:login/helpers/slider/leftsideslidericonprovider.dart';
import 'package:login/helpers/slider/slidericon.dart';
import 'package:login/screens/contractdetails.dart';
import 'package:login/screens/projectDetails.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:login/screens/searchmember.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/customsnackbar.dart';
import 'package:login/widgets/dashbord_widgets/datepick.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;
import 'package:provider/provider.dart';

class AddProject extends StatefulWidget {
  static const routeName = 'addProject';
  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  TextEditingController _whatController;
  TextEditingController _projectNameController = TextEditingController();
  TextEditingController _rateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  TextEditingController _linkController = TextEditingController();
  TextEditingController _usagesController = TextEditingController();
  TextEditingController _whenController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  DateTime _firstDate;
  DateTime _lastDate;
  bool _isLoad = false, _isInit = true;
  String _what, _where;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      // String whatValue =
      //     Provider.of<DashBoardMethods>(context, listen: false).whatValue;
      // String whereValue =
      //     Provider.of<DashBoardMethods>(context, listen: false).location;
      // String firstDate =
      //     Provider.of<DashBoardMethods>(context, listen: false).firstDate;
      // String lastDate =
      //     Provider.of<DashBoardMethods>(context, listen: false).lastDate;
      await Provider.of<LeftSideSliderIconProvider>(context, listen: false)
          .setAllIcon();
      await Provider.of<CityList>(context, listen: false).fetchCity();
      // await Provider.of<LeftSideSliderIconProvider>(context, listen: false)
      //     .setAllIcon();
      // print(firstDate);
      // print(lastDate);
      // _whereController = TextEditingController(text: whereValue);
      // _whatController = TextEditingController(text: whatValue);
      // print("whatValue" + whatValue);
      setState(() {});
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _whenController.dispose();
    _notesController.dispose();
    _whatController.dispose();
    _whenController.dispose();
    _rateController.dispose();
    _addressController.dispose();
    _linkController.dispose();
    _usagesController.dispose();
    _projectNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final cityList = Provider.of<CityList>(context).items;
    final item = Provider.of<LeftSideSliderIconProvider>(context).allIcon;
    return Scaffold(
      // key: _scaffoldKey,

      floatingActionButton:
          Builder(builder: (context) => acceptDeclineButton(size, context)),

      body: Stack(
        children: <Widget>[
          PageBackground(
              size: size, imagePath: 'assets/images/profilebackground.png'),
          _isLoad
              ? CustomCircularProgressIndicator()
              : Builder(
                  builder: (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: GestureDetector(
                      onTap: () =>
                          FocusScope.of(context).requestFocus(new FocusNode()),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            PageTitle(
                              size: size,
                              title: "Add Project",
                              callback: () {
                                Provider.of<MembersProvider>(context,
                                        listen: false)
                                    .clearSelectedMember();
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _formField(
                              lable: 'Project title',
                              width: size.width - 48,
                              fontSize: size.width < 600 ? 12 : 15,
                              image: 'assets/icons/Lickicon.png',
                              textInputType: TextInputType.text,
                              controller: _projectNameController,
                              maxLine: 1,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _showIconMyDialog(item),
                                  child: _formFieldForWhatAndWhere(
                                    lable: 'What',
                                    fontSize: size.width < 600 ? 12 : 15,
                                    image: 'assets/icons/What.png',
                                    width: size.width / 2 - 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () => _showMyDialog(cityList),
                                  child: _formFieldForWhatAndWhere(
                                      lable: 'Where',
                                      fontSize: size.width < 600 ? 12 : 15,
                                      image: 'assets/icons/Where.png',
                                      width: size.width / 2 - 30),
                                  // child: _formField(
                                  //   enable: false,
                                  //   lable: 'Where',
                                  //   width: size.width / 2 - 30,
                                  //   fontSize: 15,
                                  //   image: 'assets/icons/Where.png',
                                  //   textInputType: TextInputType.text,
                                  //   controller: _whereController,
                                  //   maxLine: 1,
                                  // ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                // whenField(context, size),
                                selectStartEndDate(context, size),
                                SizedBox(
                                  width: 12,
                                ),
                                _formField(
                                  lable: 'Rate',
                                  width: size.width / 2 - 30,
                                  fontSize: size.width < 600 ? 12 : 15,
                                  image: 'assets/icons/Dollar.png',
                                  textInputType: TextInputType.number,
                                  controller: _rateController,
                                  maxLine: 1,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _formField(
                              lable: 'Address',
                              width: size.width - 48,
                              fontSize: size.width < 600 ? 12 : 15,
                              image: 'assets/icons/Where.png',
                              textInputType: TextInputType.text,
                              controller: _addressController,
                              maxLine: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_what == null || _where == null) {
                                  return CustomSnackBar(
                                      context,
                                      'Please select what and where field first.',
                                      SnackBartype.nagetive);
                                } else {
                                  Navigator.of(context).pushNamed(
                                      SearchMember.routeName,
                                      arguments: {
                                        "what": _what,
                                        "where": _where,
                                        "members": List<Members>(),
                                      });
                                }
                              },
                              child: whoField(size),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _formField(
                              lable: 'Link',
                              width: size.width - 48,
                              fontSize: size.width < 600 ? 12 : 15,
                              image: 'assets/icons/Lickicon.png',
                              textInputType: TextInputType.text,
                              controller: _linkController,
                              maxLine: 1,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _formField(
                              lable: 'Usages',
                              width: size.width - 48,
                              fontSize: size.width < 600 ? 12 : 15,
                              image: 'assets/icons/Usages.png',
                              textInputType: TextInputType.text,
                              controller: _usagesController,
                              maxLine: null,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _formField(
                              lable: 'Notes',
                              width: size.width - 48,
                              fontSize: size.width < 600 ? 12 : 15,
                              image: 'assets/icons/Notes.png',
                              textInputType: TextInputType.text,
                              controller: _notesController,
                              maxLine: null,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Center selectStartEndDate(BuildContext context, Size size) {
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Theme(
              data: Constant.GetConstant.shared.themeData(context),
              child: Builder(
                builder: (context) => GestureDetector(
                  onTap: () async {
                    _firstDate = null;
                    _lastDate = null;
                    List<DateTime> dateTime =
                        await DateRangePicker.showDatePicker(
                            context: context,
                            initialFirstDate: DateTime.now(),
                            initialLastDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(days: 1)),
                            lastDate: DateTime(DateTime.now().year + 5));
                    print(dateTime[0]);
                    if (dateTime != null && dateTime.length == 1) {
                      setState(() {
                        _firstDate = dateTime[0];
                      });
                      // Change value in provider

                      print(" Choose Only One date" +
                          _firstDate.toIso8601String());
                    }
                    if (dateTime != null && dateTime.length == 2) {
                      setState(() {
                        _firstDate = dateTime[0];
                        _lastDate = dateTime[1];
                      });

                      print(_firstDate);
                      print(_lastDate);
                    }
                    print("_firstDate");
                  },
                  child: Container(
                    width: size.height > Constant.divSize
                        ? 320
                        : size.width / 2 - 30,
                    height: size.height > Constant.divSize ? 80 : 50,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border:
                            Border(bottom: BorderSide(color: Colors.yellow))),
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 8),
                          margin: EdgeInsets.only(left: 7),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 15,
                            child: Image.asset('assets/icons/Calender.png'),
                          ),
                        ),
                        Padding(
                          padding: size.height > Constant.divSize
                              ? const EdgeInsets.only(top: 0.0)
                              : const EdgeInsets.only(top: 8.0, bottom: 7),
                          child: Text(
                            _firstDate == null && _lastDate == null
                                ? 'Select start - end date'
                                : _firstDate != null && _lastDate == null
                                    ? '${DateFormat("dd-MMM-yyyy").format(_firstDate)}'
                                    : '${DateFormat("dd-MMM").format(_firstDate)} | ${DateFormat("dd-MMM-yyyy").format(_lastDate)}',
                            style: TextStyle(
                                fontSize: size.width < 600 ? 11.5 : 14,
                                color: Constant.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Consumer<MembersProvider> whoField(Size size) {
    return Consumer<MembersProvider>(
      builder: (context, memberObj, ch) => Container(
        margin: EdgeInsets.only(
          right: 13,
        ),
        width: size.height > Constant.divSize ? 320 : size.width,
        height: size.height > Constant.divSize ? 80 : 60,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(bottom: BorderSide(color: Constant.primaryColor))),
        padding: EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 8),
              margin: EdgeInsets.only(left: 7),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 16,
                child: Image.asset('assets/icons/Afflicated.png'),
              ),
            ),
            Padding(
                padding: size.height > Constant.divSize
                    ? const EdgeInsets.only(top: 0.0)
                    : const EdgeInsets.only(top: 8.0, bottom: 8, left: 5),
                child: Container(
                  height: 15,
                  width: size.width - 150,
                  child: memberObj.selectedMembers.length == 0
                      ? Text(
                          "Who",
                          style: TextStyle(
                              fontSize: size.width < 600 ? 11.5 : 14,
                              color: Constant.primaryColor),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => Text(
                            ", ",
                            style: TextStyle(color: Constant.primaryColor),
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) => Text(
                            memberObj.selectedMembers[i].name,
                            style: TextStyle(
                                fontSize: size.width < 600 ? 11.5 : 14,
                                color: Constant.primaryColor),
                          ),
                          itemCount: memberObj.selectedMembers.length,
                        ),
                )),
          ],
        ),
      ),
    );
  }

  // whenField(BuildContext context, Size size) {
  //   return GestureDetector(
  //     onTap: () async {
  //       _firstDate = null;
  //       _lastDate = null;
  //       List<DateTime> dateTime = await DateRangePicker.showDatePicker(
  //           context: context,
  //           initialFirstDate: DateTime.now(),
  //           initialLastDate: DateTime.now(),
  //           firstDate: DateTime.now().subtract(Duration(days: 1)),
  //           lastDate: DateTime(DateTime.now().year + 5));
  //       print(dateTime[0]);
  //       if (dateTime != null && dateTime.length == 1) {
  //         setState(() {
  //           _firstDate = dateTime[0];
  //         });
  //         // Change value in provider
  //         // dashboardMethods
  //         //     .changeFirstDate(DateFormat("dd-MMM").format(_firstDate));
  //         print(" Choose Only One date" + _firstDate.toIso8601String());
  //       }
  //       if (dateTime != null && dateTime.length == 2) {
  //         setState(() {
  //           _firstDate = dateTime[0];
  //           _lastDate = dateTime[1];
  //         });
  //         // dashboardMethods
  //         //     .changeFirstDate(DateFormat("dd-MMM").format(_firstDate));
  //         // dashboardMethods
  //         //     .changeLastDate(DateFormat("dd-MMM-yyyy").format(_lastDate));

  //         print(_firstDate);
  //         print(_lastDate);
  //       }
  //       print("_firstDate");
  //       // print(dashboardMethods.whatValue);
  //       // print(dashboardMethods.location);
  //     },
  //     child: _formField(
  //       lable: 'When',
  //       width: size.width / 2 - 30,
  //       fontSize: 15,
  //       image: 'assets/icons/Calender.png',
  //       textInputType: TextInputType.text,
  //       controller: _whenController,
  //       maxLine: 1,
  //       enable: false,
  //     ),
  //   );
  // }

  Widget _formFieldForWhatAndWhere(
      {String lable, double width, double fontSize, String image}) {
    return Container(
      width: width,
      child: TextFormField(
        enabled: false,
        cursorColor: Colors.black,
        style: TextStyle(
          color: Constant.primaryColor,
          fontSize: fontSize,
        ),
        decoration: InputDecoration(
          disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Constant.primaryColor)),
          hintText: lable == 'What'
              ? _what == null ? 'What' : _what
              : _where == null ? 'Where' : _where,
          hintStyle: TextStyle(
              color: Constant.primaryColor, height: 1.5, fontSize: fontSize),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Constant.primaryColor),
          ),
          prefixIcon: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 10,
              child: Image.asset(image),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Constant.primaryColor),
          ),
        ),
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

  bool validateField(BuildContext context) {
    int len = Provider.of<MembersProvider>(context, listen: false)
        .getSerchMemberListLenght;
    print(len);
    if (_projectNameController.text.isEmpty) {
      CustomSnackBar(
          context, 'Please enter project name', SnackBartype.nagetive);
      return false;
    } else if (_rateController.text.isEmpty) {
      CustomSnackBar(context, 'Please enter rate', SnackBartype.nagetive);
      return false;
    } else if (_what == null) {
      CustomSnackBar(context, 'Please select what', SnackBartype.nagetive);
      return false;
    } else if (_where == null) {
      CustomSnackBar(context, 'Please select where', SnackBartype.nagetive);
      return false;
    } else if (_linkController.text.isEmpty) {
      CustomSnackBar(context, 'Please enter link', SnackBartype.nagetive);
      return false;
    } else if (_addressController.text.isEmpty) {
      CustomSnackBar(context, 'Please enter address', SnackBartype.nagetive);
      return false;
    } else if (_usagesController.text.isEmpty) {
      CustomSnackBar(context, 'Please enter usages', SnackBartype.nagetive);
      return false;
    } else if (_notesController.text.isEmpty) {
      CustomSnackBar(context, 'Please enter notes', SnackBartype.nagetive);
      return false;
    } else if (_firstDate == null || _lastDate == null) {
      CustomSnackBar(
          context, 'Please select start and end date', SnackBartype.nagetive);
      return false;
    } else if (len == 0) {
      CustomSnackBar(
          context, 'Please select one or more member', SnackBartype.nagetive);
      return false;
    } else {
      return true;
    }
  }

  Future<void> _showIconMyDialog(List<String> list) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<DashBoardMethods>(
          builder: (context, dashboardMethods, ch) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: Color.fromRGBO(37, 36, 41, 1),
            content: Container(
              height: 200,
              width: 200,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, i) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        dashboardMethods.changeWhereValue(list[i]);
                        setState(() {
                          _what = list[i];
                          // _whereSelect = true;
                        });
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        title: Align(
                          alignment: Alignment.center,
                          child: Text(
                            list[i],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showMyDialog(List<City> cityList) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<DashBoardMethods>(
          builder: (context, dashboardMethods, ch) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: Color.fromRGBO(37, 36, 41, 1),
            content: Container(
              height: 200,
              width: 200,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: cityList.length,
                itemBuilder: (context, i) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        dashboardMethods.changeWhereValue(cityList[i].cityName);
                        setState(() {
                          _where = cityList[i].cityName;
                          // _whereSelect = true;
                        });
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        title: Align(
                          alignment: Alignment.center,
                          child: Text(
                            cityList[i].cityName,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _submit() async {
    // setState(() {
    //   _isLoad = true;
    // });
    // print(_whatController.text);
    // print(_whereController.text);
    // print(_whenController.text);
    // print(_whoController.text);
    // print(_linkController.text);
    // print(_usagesController.text);
    // print(_notesController.text);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ContractDetails(
              what: _what,
              where: _where,
              projectName: _projectNameController.text,
              startDate: _firstDate.toIso8601String(),
              endDate: _lastDate.toIso8601String(),
              address: _addressController.text,
              link: _linkController.text,
              notes: _notesController.text,
              rate: _rateController.text,
              usages: _usagesController.text,
            )));

    setState(() {
      _isLoad = false;
    });
    // _whatController.clear();
    // _whereController.clear();
    // _addressController.clear();
    // _linkController.clear();
    // _rateController.clear();
    // _notesController.clear();
    // _usagesController.clear();
    // _whenController.clear();
  }

  Row acceptDeclineButton(Size size, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // print("_firstDate" + _firstDate.toIso8601String());
            // print("_lastDate" + _lastDate.toIso8601String());
            if (validateField(context)) {
              _submit();
              // } else {
              //   CustomSnackBar(context, "Please agree SUPREME card policy",
              //       SnackBartype.nagetive);
            }
          },
          child: Container(
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: size.height > Constant.divSize ? 40 : 30,
                child: Image.asset('assets/icons/Acept.png')),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {
            // setState(() {
            //   _isEdit = false;
            // });
            // Navigator.of(context)
            //     .pushReplacementNamed(ServiceProvider.routeName);
          },
          child: Container(
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: size.height > Constant.divSize ? 40 : 30,
                child: Image.asset('assets/icons/Decline.png')),
          ),
        ),
      ],
    );
  }
}
