import 'package:flutter/material.dart';
import 'package:login/helpers/Providers/contract_details_provider.dart';
import 'package:login/screens/allcontract.dart';
import 'package:login/screens/contract.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;
import 'package:provider/provider.dart';

class Contract extends StatefulWidget {
  static const routeName = '/Contract';

  @override
  _ContractState createState() => _ContractState();
}

class _ContractState extends State<Contract> {
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
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: floatingButtonForContract(size, context),
      body: Stack(
        children: <Widget>[
          PageBackground(size: size, imagePath: 'assets/background.png'),
          Consumer<ContractDetailProvider>(
            builder: (context, Contract, ch) => Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PageTitle(size: size, title: "Contract"),
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
                          customTitleContent(size, "Project Details",
                              Contract.contract.projectDetail),
                          SizedBox(
                            height: size.height > Constant.divSize ? 25 : 10,
                          ),
                          customTitleContent(
                              size, "Location", Contract.contract.location),
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
                                    Contract.contract.teamMembers[i],
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: size.height > Constant.divSize
                                          ? 20
                                          : size.width < 600 ? 10 : 15,
                                    ),
                                  )),
                              itemCount: Contract.contract.taskList.length,
                            ),
                          ),
                          SizedBox(
                            height: size.height > Constant.divSize ? 25 : 10,
                          ),
                          Text(
                            'Task',
                            style: TextStyle(
                              color: Constant.primaryColor,
                              fontSize: size.height > Constant.divSize
                                  ? 25
                                  : size.width < 600 ? 10 : 15,
                            ),
                          ),
                          SizedBox(
                            height: size.height > Constant.divSize ? 25 : 10,
                          ),
                          Container(
                            color: _isEdit
                                ? Colors.grey.withOpacity(.2)
                                : Colors.grey.withOpacity(0),
                            padding: EdgeInsets.only(left: 20),
                            margin: EdgeInsets.only(right: 30),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, i) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Hello World",
                                  maxLines: null,
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 15),
                                  // decoration: InputDecoration(
                                  //     // filled: true,
                                  //     isDense: true,
                                  //     border: OutlineInputBorder(
                                  //         borderSide: BorderSide.none),
                                  //     hintText: "Enter Link",
                                  //     hintStyle: TextStyle(color: Colors.white54),
                                  //     // fillColor: Colors.grey[850],
                                  //     contentPadding: EdgeInsets.all(10)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          customTitleContent(
                              size, "Amount", Contract.contract.amount),
                          customTitleContent(
                              size, "Duration", Contract.contract.date),
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

  Row floatingButtonForContract(Size size, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
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
                builder: (BuildContext context) => AllContract()));
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
