import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Providers/membersprovider.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:login/helpers/Providers/request_provider.dart';
import 'package:login/screens/contract.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:login/helpers/Constant/constant.dart' as Constant;
import 'package:provider/provider.dart';

class ContractDetails extends StatefulWidget {
  static const routeName = '/contractDetails';

  ContractDetails({
    this.what,
    this.where,
    this.address,
    this.endDate,
    this.link,
    this.notes,
    this.rate,
    this.startDate,
    this.projectName,
    this.usages,
  });

  final String what,
      where,
      projectName,
      startDate,
      endDate,
      rate,
      link,
      usages,
      address,
      notes;

  @override
  _ContractDetailsState createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  List<TextEditingController> taskListController = [];
  List<String> data = [], newList = [];
  int _length;
  var fieldCount;
  DateTime _lastDate, _firstDate;
  bool _isLoad = false, _isInit = true;
  // ContractD contract;

  // bool _isEdit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // contract =
    //     Provider.of<ContractDetailProvider>(context, listen: false).contract;
    // data = contract.taskList;
    if (_isInit) {
      _length = data.length;
      fieldCount = data.length;
      _firstDate = DateTime.parse(widget.startDate);
      _lastDate = DateTime.parse(widget.endDate);
      _isInit = false;
    }

    print(widget.what);
    print(widget.where);
    print(widget.address);
    print(widget.startDate);
    print(widget.endDate);
    print(widget.notes);
  }

  @override
  void dispose() {
    super.dispose();
    for (var i = 0; i < data.length; i++) {
      taskListController[i].dispose();
      // linkController[i].dispose();
    }
  }

  List<Widget> _buildList() {
    // for (var i = 0; i < _length; i++) {
    //   if (data[i]['init'] == false) {
    //     taskListController.add(TextEditingController(text: data[i]['content']));
    //     data[i]['init'] = true;
    //   }
    // }

    if (taskListController.length < fieldCount) {
      for (var i = taskListController.length; i < fieldCount; i++) {
        taskListController.add(TextEditingController());
      }
    }
    List<Widget> list = [];
    for (var i = 0; i < taskListController.length; i++) {
      list.add(Column(
        key: Key("$i"),
        children: [
          Row(
            children: [
              GestureDetector(
                key: Key("$i"),
                onTap:
                    // _isEdit
                    //     ?
                    () {
                  setState(() {
                    fieldCount--;
                    taskListController.remove(taskListController[i]);
                  });
                },
                // : null,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  // enabled:  true : false,
                  controller: taskListController[i],
                  maxLines: null,
                  style: TextStyle(color: Colors.white54, fontSize: 15),
                  decoration: InputDecoration(
                      // filled: true,
                      isDense: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Enter task",
                      hintStyle: TextStyle(color: Colors.white54),
                      // fillColor: Colors.grey[850],
                      contentPadding: EdgeInsets.all(10)),
                ),
              ),
            ],
          ),
        ],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Widget> children = _buildList();
    return Scaffold(
      floatingActionButton: floatingButtonForContractDetails(size, context),
      body: Stack(
        children: <Widget>[
          PageBackground(
              size: size, imagePath: 'assets/images/contract_detail_bg.png'),
          _isLoad
              ? CustomCircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PageTitle(size: size, title: "Contract Detils"),
                        SizedBox(
                          height: size.height > Constant.divSize ? 20 : 8,
                        ),
                        Padding(
                          padding: size.height > Constant.divSize
                              ? const EdgeInsets.all(28.0)
                              : const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              customTitleContent(size, "Project", widget.notes),
                              SizedBox(
                                height:
                                    size.height > Constant.divSize ? 25 : 10,
                              ),
                              customTitleContent(
                                  size, "Location", widget.where),
                              SizedBox(
                                height:
                                    size.height > Constant.divSize ? 25 : 10,
                              ),
                              Text(
                                'Team Member',
                                style: TextStyle(
                                  color: Constant.primaryColor,
                                  fontSize: size.height > Constant.divSize
                                      ? 25
                                      : size.width < 600 ? 10 : 15,
                                ),
                              ),
                              SizedBox(
                                height:
                                    size.height > Constant.divSize ? 15 : 10,
                              ),
                              Consumer<MembersProvider>(
                                builder: (context, memberObj, ch) => Container(
                                  height: 30,
                                  width: size.width,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Constant.GetConstant.shared.text(
                                      text: ' , ',
                                      color: Colors.white38,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          memberObj.selectedMembers[i].name,
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: size.height >
                                                    Constant.divSize
                                                ? 20
                                                : size.width < 600 ? 10 : 15,
                                          ),
                                        )),
                                    itemCount: memberObj.selectedMembers.length,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    size.height > Constant.divSize ? 25 : 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Task',
                                    style: TextStyle(
                                      color: Constant.primaryColor,
                                      fontSize: size.height > Constant.divSize
                                          ? 25
                                          : size.width < 600 ? 10 : 15,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap:
                                        // !_isEdit
                                        //     ? () {
                                        //         setState(() {
                                        //           _isEdit = !_isEdit;
                                        //         });
                                        //         print(data.length);
                                        //       }
                                        // :
                                        () {
                                      setState(() {
                                        fieldCount++;
                                      });
                                      print(data.length);
                                    },
                                    child: Container(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 15,
                                        child:
                                            // _isEdit
                                            //     ? Image.asset(
                                            //         'assets/icons/profileIcon.png')
                                            // :
                                            Image.asset(
                                                'assets/icons/Edit_Icon.png'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                color:
                                    // _isEdit
                                    // ?
                                    Colors.grey.withOpacity(.2),
                                // : Colors.grey.withOpacity(0),
                                padding: EdgeInsets.only(left: 20),
                                margin: EdgeInsets.only(right: 30),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: children,
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      iconContent(
                                          size: size,
                                          content: widget.rate,
                                          image: 'assets/icons/Amount.png'),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Theme(
                                        data: Constant.GetConstant.shared
                                            .themeData(context),
                                        child: Builder(
                                          builder: (context) => GestureDetector(
                                            onTap: () async {
                                              _firstDate = null;
                                              _lastDate = null;
                                              List<DateTime> dateTime =
                                                  await DateRangePicker
                                                      .showDatePicker(
                                                          context: context,
                                                          initialFirstDate:
                                                              DateTime.now(),
                                                          initialLastDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime
                                                                  .now()
                                                              .subtract(
                                                                  Duration(
                                                                      days: 1)),
                                                          lastDate: DateTime(
                                                              DateTime.now()
                                                                      .year +
                                                                  5));
                                              print(dateTime[0]);
                                              if (dateTime != null &&
                                                  dateTime.length == 1) {
                                                setState(() {
                                                  _firstDate = dateTime[0];
                                                });
                                                // Change value in provider

                                                print(" Choose Only One date" +
                                                    _firstDate
                                                        .toIso8601String());
                                              }
                                              if (dateTime != null &&
                                                  dateTime.length == 2) {
                                                setState(() {
                                                  _firstDate = dateTime[0];
                                                  _lastDate = dateTime[1];
                                                });

                                                print(_firstDate);
                                                print(_lastDate);
                                              }
                                              print("_firstDate");
                                            },
                                            child: iconContent(
                                                size: size,
                                                content: DateFormat('dd-MMM')
                                                        .format(_firstDate) +
                                                    '-' +
                                                    DateFormat('dd-MMM-yyyy')
                                                        .format(_lastDate),
                                                image:
                                                    'assets/icons/Select_Date.png'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  _submit() async {
    print(taskListController.length);
    newList.clear();
    for (var i = 0; i < taskListController.length; i++) {
      newList.add(
        taskListController[i].text,
      );
    }
    final selectedMemberList =
        Provider.of<MembersProvider>(context, listen: false).selectedMembers;
    List<Map> list = [];
    for (var i = 0; i < selectedMemberList.length; i++) {
      list.add(
        {"userid": selectedMemberList[i].id, "status": 0},
      );
    }
    setState(() {
      _isLoad = true;
    });
    await Provider.of<ProjectProvider>(context, listen: false).addProject(
      where: widget.where,
      what: widget.what,
      startDate: _firstDate.toIso8601String(),
      endDate: _lastDate.toIso8601String(),
      link: widget.link,
      notes: widget.notes,
      projectName: widget.projectName,
      address: widget.address,
      memberList: list,
      rate: widget.rate,
      usages: widget.usages,
      taskList: newList,
    );
    await Provider.of<RequestProvider>(context, listen: false)
        .loadAllProjectRequests();
    await Provider.of<ProjectProvider>(context, listen: false).loadAllProject();
    Provider.of<MembersProvider>(context, listen: false).clearSelectedMember();

    setState(() {
      _isLoad = false;
    });
    Navigator.pop(context);
    Navigator.pop(context);
    print(newList);
  }

  Row floatingButtonForContractDetails(Size size, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: _submit,
          child: Container(
            child: CustomCircleAvatarForIcon(
              radius: size.height > Constant.divSize ? 40 : 30,
              image: 'assets/icons/Acept.png',
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Contract()));
          },
          child: Container(
            child: CustomCircleAvatarForIcon(
              radius: size.height > Constant.divSize ? 40 : 30,
              image: 'assets/icons/Decline.png',
            ),
          ),
        ),
      ],
    );
  }

  Row iconContent({Size size, dynamic content, String image}) {
    return Row(
      children: <Widget>[
        Container(
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: size.width < 600 ? 25 : 30,
              child: Image.asset(image)),
        ),
        SizedBox(
          width: size.width < 600 ? 10 : 15,
        ),
        Text(
          content,
          style: TextStyle(
            color: Colors.white54,
            fontSize: size.width < 600 ? 10 : 15,
          ),
        ),
      ],
    );
  }

  Widget customTitleContent(Size size, String title, String content) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Constant.primaryColor,
              fontSize: size.height > Constant.divSize
                  ? 25
                  : size.width < 600 ? 10 : 15,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            content,
            style: TextStyle(
              color: Colors.white60,
              fontSize: size.height > Constant.divSize
                  ? 20
                  : size.width < 600 ? 10 : 15,
            ),
          ),
        ],
      ),
    );
  }
}
