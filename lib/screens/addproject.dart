import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:login/screens/projectDetails.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class AddProject extends StatefulWidget {
  static const routeName = 'addProject';
  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  TextEditingController _whatController = TextEditingController();
  TextEditingController _whereController = TextEditingController();
  TextEditingController _rateController = TextEditingController();
  TextEditingController _whoController = TextEditingController();
  TextEditingController _linkController = TextEditingController();
  TextEditingController _usagesController = TextEditingController();
  TextEditingController _whenController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  DateTime _dateTime;
  bool _isLoad = false;

  @override
  void dispose() {
    super.dispose();
    _whenController.dispose();
    _notesController.dispose();
    _whatController.dispose();
    _whenController.dispose();
    _rateController.dispose();
    _whoController.dispose();
    _linkController.dispose();
    _usagesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                              _formField(
                                lable: 'What',
                                width: size.width / 2 - 30,
                                fontSize: 15,
                                image: 'assets/icons/What.png',
                                textInputType: TextInputType.text,
                                controller: _whatController,
                                maxLine: 1,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              _formField(
                                lable: 'Where',
                                width: size.width / 2 - 30,
                                fontSize: 15,
                                image: 'assets/icons/Where.png',
                                textInputType: TextInputType.text,
                                controller: _whereController,
                                maxLine: 1,
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
                          _formField(
                            lable: 'Who',
                            width: size.width - 48,
                            fontSize: 15,
                            image: 'assets/icons/user.png',
                            textInputType: TextInputType.text,
                            controller: _whoController,
                            maxLine: 1,
                          ),
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
        image: 'assets/icons/calender.png',
        textInputType: TextInputType.text,
        controller: _whenController,
        maxLine: 1,
        enable: false,
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

  void _submit() async {
    setState(() {
      _isLoad = true;
    });
    print(_whatController.text);
    print(_whereController.text);
    print(_whenController.text);
    print(_whoController.text);
    print(_linkController.text);
    print(_usagesController.text);
    print(_notesController.text);

    setState(() {
      _isLoad = false;
    });
    _whatController.clear();
    _whereController.clear();
    _whoController.clear();
    _linkController.clear();
    _rateController.clear();
    _notesController.clear();
    _usagesController.clear();
    _whenController.clear();
    // Navigator.of(context).pushReplacementNamed(ServiceProvider.routeName);
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
