import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:login/helpers/Providers/request_provider.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/customcircularprogressindicator.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;
import 'package:provider/provider.dart';

class Contract extends StatefulWidget {
  static const routeName = '/Contract';
  final Receiverequest byThemPrjObj;

  Contract({this.byThemPrjObj});
  @override
  _ContractState createState() => _ContractState();
}

class _ContractState extends State<Contract> {
  // List<Map> data = [], newList = [];
  // int _length;
  // var fieldCount;
  // ContractD contract;

  bool _isLoad = false;

  // @override
  // void didChangeDependencies() {
  // super.didChangeDependencies();
  // contract =
  //     Provider.of<ContractDetailProvider>(context, listen: false).contract;
  // data = contract.taskList;
  // _length = data.length;
  // fieldCount = data.length;
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: floatingButtonForContract(size, context),
      body: Stack(
        children: <Widget>[
          PageBackground(
              size: size, imagePath: 'assets/images/contract_bg.png'),
          _isLoad
              ? CustomCircularProgressIndicator()
              : Padding(
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
                              customTitleContent(
                                  size,
                                  "Project Details",
                                  widget.byThemPrjObj.notes == null
                                      ? ''
                                      : widget.byThemPrjObj.notes),
                              SizedBox(
                                height:
                                    size.height > Constant.divSize ? 25 : 10,
                              ),
                              customTitleContent(
                                  size, "Location", widget.byThemPrjObj.where),
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
                              Container(
                                height: 30,
                                width: size.width,
                                child: ListView.separated(
                                  separatorBuilder: (context, i) => Text(
                                    ' , ',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        widget.byThemPrjObj.members[i].sId,
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize:
                                              size.height > Constant.divSize
                                                  ? 20
                                                  : size.width < 600 ? 10 : 15,
                                        ),
                                      )),
                                  itemCount: widget.byThemPrjObj.members.length,
                                ),
                              ),
                              SizedBox(
                                height:
                                    size.height > Constant.divSize ? 25 : 10,
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
                                height:
                                    size.height > Constant.divSize ? 25 : 10,
                              ),
                              Container(
                                color: Colors.grey.withOpacity(0),
                                padding: EdgeInsets.only(left: 20),
                                margin: EdgeInsets.only(right: 30),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.byThemPrjObj.tasks.length,
                                  itemBuilder: (context, i) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          child: Image.asset(
                                              'assets/icons/Location_icon.png'),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.byThemPrjObj.tasks[i],
                                          maxLines: null,
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 15),
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              customTitleContent(size, "Amount",
                                  widget.byThemPrjObj.price.toString()),
                              SizedBox(
                                height: 10,
                              ),
                              customTitleContent(
                                  size,
                                  "Duration",
                                  DateFormat('dd-MMM-yyyy').format(
                                          DateTime.parse(
                                              widget.byThemPrjObj.startDate)) +
                                      ' | ' +
                                      DateFormat('dd-MMM-yyyy').format(
                                          DateTime.parse(
                                              widget.byThemPrjObj.endDate))),
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
    setState(() {
      _isLoad = true;
    });
    await Provider.of<ProjectProvider>(context, listen: false)
        .acceptProjectRequest(projId: widget.byThemPrjObj.sId, status: 1);
    await Provider.of<RequestProvider>(context, listen: false)
        .loadAllProjectRequests();
    // Provider.of<DashBoardMethods>(context, listen: false)
    //     .changeDashboardWidget('allRequest');
    setState(() {
      _isLoad = false;
    });
    Navigator.pop(context);
  }

  Row floatingButtonForContract(Size size, BuildContext context) {
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
          onTap: () async {
            await Provider.of<ProjectProvider>(context, listen: false)
                .acceptProjectRequest(
                    projId: widget.byThemPrjObj.sId, status: 2);
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (BuildContext context) => AllContract()));
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
