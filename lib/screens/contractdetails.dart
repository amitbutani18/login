import 'package:flutter/material.dart';
import 'package:login/helpers/Providers/contract_details_provider.dart';
import 'package:login/screens/contract.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;
import 'package:provider/provider.dart';

class ContractDetails extends StatefulWidget {
  static const routeName = '/contractDetails';

  @override
  _ContractDetailsState createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  List<TextEditingController> taskListController = [];
  List<Map> data = [], newList = [];
  int _length;
  var fieldCount;
  ContractD contract;

  bool _isEdit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    contract =
        Provider.of<ContractDetailProvider>(context, listen: false).contract;
    data = contract.taskList;
    _length = data.length;
    fieldCount = data.length;
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
    for (var i = 0; i < _length; i++) {
      if (data[i]['init'] == false) {
        taskListController.add(TextEditingController(text: data[i]['content']));
        data[i]['init'] = true;
      }
    }

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
                onTap: _isEdit
                    ? () {
                        setState(() {
                          fieldCount--;
                          taskListController.remove(taskListController[i]);
                        });
                      }
                    : null,
                child: Icon(
                  Icons.delete,
                  color: _isEdit ? Colors.red : Colors.grey,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  enabled: _isEdit ? true : false,
                  controller: taskListController[i],
                  maxLines: null,
                  style: TextStyle(color: Colors.white54, fontSize: 15),
                  decoration: InputDecoration(
                      // filled: true,
                      isDense: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Enter Link",
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
          PageBackground(size: size, imagePath: 'assets/background.png'),
          Consumer<ContractDetailProvider>(
            builder: (context, contractDetails, ch) => Padding(
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
                          customTitleContent(size, "Project",
                              contractDetails.contract.projectDetail),
                          SizedBox(
                            height: size.height > Constant.divSize ? 25 : 10,
                          ),
                          customTitleContent(size, "Location",
                              contractDetails.contract.location),
                          SizedBox(
                            height: size.height > Constant.divSize ? 25 : 10,
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
                            height: size.height > Constant.divSize ? 15 : 10,
                          ),
                          Container(
                            height: 30,
                            width: size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, i) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    contractDetails.contract.teamMembers[i],
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: size.height > Constant.divSize
                                          ? 20
                                          : size.width < 600 ? 10 : 15,
                                    ),
                                  )),
                              itemCount:
                                  contractDetails.contract.taskList.length,
                            ),
                          ),
                          SizedBox(
                            height: size.height > Constant.divSize ? 25 : 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                onTap: !_isEdit
                                    ? () {
                                        setState(() {
                                          _isEdit = !_isEdit;
                                        });
                                        print(data.length);
                                      }
                                    : () {
                                        setState(() {
                                          fieldCount++;
                                        });
                                        print(data.length);
                                      },
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 15,
                                    child: _isEdit
                                        ? Image.asset(
                                            'assets/icons/profileIcon.png')
                                        : Image.asset(
                                            'assets/icons/Edit_Icon.png'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: _isEdit
                                ? Colors.grey.withOpacity(.2)
                                : Colors.grey.withOpacity(0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  iconContent(
                                      size: size,
                                      content: contractDetails.contract.amount,
                                      image: 'assets/icons/Amount.png'),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  iconContent(
                                      size: size,
                                      content: contractDetails.contract.amount,
                                      image: 'assets/icons/Select_Date.png'),
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
          ),
        ],
      ),
    );
  }

  Row floatingButtonForContractDetails(Size size, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            for (var i = 0; i < taskListController.length; i++) {
              newList.add(
                {'content': taskListController[i].text, 'init': false},
              );
            }
            print(newList);
          },
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
              radius: size.height > Constant.divSize ? 40 : 30,
              child: Image.asset(image)),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          content,
          style: TextStyle(
            color: Colors.white54,
            fontSize: size.height > Constant.divSize ? 30 : 15,
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
// 321
