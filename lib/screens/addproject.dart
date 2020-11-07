import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Constant/providers_list.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:login/helpers/citylist.dart';
import 'package:login/helpers/dashboard_method.dart';
import 'package:login/helpers/slider/leftsideslidericonprovider.dart';
import 'package:login/helpers/slider/slidericon.dart';
import 'package:login/screens/projectDetails.dart';
import 'package:login/screens/searchmember.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
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
  TextEditingController _whereController;
  TextEditingController _rateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  TextEditingController _linkController = TextEditingController();
  TextEditingController _usagesController = TextEditingController();
  TextEditingController _whenController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  DateTime _dateTime;
  bool _isLoad = false, _isInit = true;
  String _what, _where;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      String whatValue =
          Provider.of<DashBoardMethods>(context, listen: false).whatValue;
      String whereValue =
          Provider.of<DashBoardMethods>(context, listen: false).location;
      String firstDate =
          Provider.of<DashBoardMethods>(context, listen: false).firstDate;
      String lastDate =
          Provider.of<DashBoardMethods>(context, listen: false).lastDate;
      await Provider.of<LeftSideSliderIconProvider>(context, listen: false)
          .setAllIcon();
      await Provider.of<CityList>(context, listen: false).fetchCity();
      // await Provider.of<LeftSideSliderIconProvider>(context, listen: false)
      //     .setAllIcon();
      print(firstDate);
      print(lastDate);
      _whereController = TextEditingController(text: whereValue);
      _whatController = TextEditingController(text: whatValue);
      print("whatValue" + whatValue);
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
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(new FocusNode()),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          PageTitle(size: size, title: "Add Project"),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => _showIconMyDialog(item),
                                child: _formFieldForWhatAndWhere(
                                  lable: 'What',
                                  fontSize: 15,
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
                                    fontSize: 15,
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
                            height: 20,
                          ),
                          Row(
                            children: [
                              whenField(context, size),
                              SizedBox(
                                width: 12,
                              ),
                              _formField(
                                lable: 'Rate',
                                width: size.width / 2 - 30,
                                fontSize: 15,
                                image: 'assets/icons/Dollar.png',
                                textInputType: TextInputType.emailAddress,
                                controller: _rateController,
                                maxLine: 1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 13),
                            width: size.height > Constant.divSize
                                ? 320
                                : size.width,
                            height: size.height > Constant.divSize ? 80 : 60,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Constant.primaryColor))),
                            padding: EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 8),
                                  margin: EdgeInsets.only(left: 5),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 16,
                                    child: Image.asset(
                                        'assets/icons/Calender.png'),
                                  ),
                                ),
                                Padding(
                                    padding: size.height > Constant.divSize
                                        ? const EdgeInsets.only(top: 0.0)
                                        : const EdgeInsets.only(
                                            top: 8.0, bottom: 8),
                                    child: Container(
                                      height: 15,
                                      width: size.width - 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i) => Text(
                                          'Amit Butani,',
                                          style: TextStyle(
                                              fontSize:
                                                  size.height > Constant.divSize
                                                      ? 20
                                                      : 14,
                                              color: Constant.primaryColor),
                                        ),
                                        itemCount: 3,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Address',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/Where.png',
                            textInputType: TextInputType.text,
                            controller: _addressController,
                            maxLine: 1,
                          ),
                          // GestureDetector(
                          //   onTap: () => Navigator.of(context)
                          //       .pushNamed(SearchMember.routeName),
                          //   child: _formField(
                          //     enable: false,
                          //     lable: 'Who',
                          //     width: size.width - 48,
                          //     fontSize: 15,
                          //     image: 'assets/icons/user.png',
                          //     textInputType: TextInputType.text,
                          //     controller: _whoController,
                          //     maxLine: 1,
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Link',
                            width: size.width - 48,
                            fontSize: 15,
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
                            fontSize: 15,
                            image: 'assets/icons/Usages.png',
                            textInputType: TextInputType.text,
                            controller: _usagesController,
                            maxLine: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _formField(
                            lable: 'Notes',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/Notes.png',
                            textInputType: TextInputType.text,
                            controller: _notesController,
                            maxLine: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  whenField(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () async {
        await showRoundedDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 1)),
                lastDate: DateTime(DateTime.now().year + 1),
                borderRadius: 16,
                theme: Constant.GetConstant.shared.themeData(context))
            .then((pickdate) {
          if (pickdate == null) {
            return;
          }
          setState(() {
            _whenController.text = DateFormat().add_yMd().format(pickdate);
          });
        });
      },
      child: _formField(
        lable: 'When',
        width: size.width / 2 - 30,
        fontSize: 15,
        image: 'assets/icons/Calender.png',
        textInputType: TextInputType.text,
        controller: _whenController,
        maxLine: 1,
        enable: false,
      ),
    );
  }

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

  // bool validateField(BuildContext context) {
  //   if (!Validation.shared.isEmailValidation(_emailController.text)) {
  //     CustomSnackBar(context, Constant.emailMsg, SnackBartype.nagetive);
  //     return false;
  //   } else if (_passwordController.text.length <= 0) {
  //     CustomSnackBar(context, Constant.passwordMsg, SnackBartype.nagetive);
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

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

    await Provider.of<ProjectProvider>(context, listen: false).addProject(
      where: _where,
      what: _what,
      dateTime: _whenController.text,
      link: _linkController.text,
      notes: _notesController.text,
      address: _addressController.text,
      rate: _rateController.text,
      usages: _usagesController.text,
    );

    setState(() {
      _isLoad = false;
    });
    _whatController.clear();
    _whereController.clear();
    _addressController.clear();
    _linkController.clear();
    _rateController.clear();
    _notesController.clear();
    _usagesController.clear();
    _whenController.clear();
    Navigator.of(context).pushNamed(SearchMember.routeName);
  }

  Row acceptDeclineButton(Size size, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // if (_checked) {
            _submit();
            // } else {
            //   CustomSnackBar(context, "Please agree SUPREME card policy",
            //       SnackBartype.nagetive);
            // }
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
