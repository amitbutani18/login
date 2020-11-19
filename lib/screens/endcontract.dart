import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:login/widgets/custom_input_decoration.dart';
import 'package:login/widgets/dashed_rect.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class EndContract extends StatefulWidget {
  static const routeName = '/endContract';
  final ByThem byThemProjectObj;

  EndContract({this.byThemProjectObj});
  @override
  _EndContractState createState() => _EndContractState();
}

class _EndContractState extends State<EndContract> {
  TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () => _showMyDialog(size),
        child: Container(
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: size.height > Constant.divSize ? 40 : 30,
              child: Image.asset('assets/icons/End_Contract.png')),
        ),
      ),
      body: Stack(
        children: <Widget>[
          PageBackground(
              size: size, imagePath: 'assets/images/profilebackground.png'),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PageTitle(
                      size: size,
                      title: 'End Contract',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: size.height > Constant.divSize
                          ? const EdgeInsets.all(28.0)
                          : const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Project Detail",
                            style: TextStyle(
                              color: Constant.primaryColor,
                              fontSize:
                                  size.height > Constant.divSize ? 30 : 20,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(
                            height: size.height > Constant.divSize ? 15 : 10,
                          ),
                          Text(
                            widget.byThemProjectObj.notes,
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize:
                                    size.height > Constant.divSize ? 25 : 15,
                                letterSpacing: 1.2),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Responsibility",
                            style: TextStyle(
                              color: Constant.primaryColor,
                              fontSize:
                                  size.height > Constant.divSize ? 30 : 20,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(
                            height: size.height > Constant.divSize ? 15 : 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, i) => Row(
                              children: <Widget>[
                                Icon(
                                  Icons.adjust,
                                  size:
                                      size.height > Constant.divSize ? 25 : 15,
                                  color: Colors.white54,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  widget.byThemProjectObj.tasks[i],
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: size.height > Constant.divSize
                                        ? 25
                                        : 15,
                                  ),
                                ),
                              ],
                            ),
                            itemCount: widget.byThemProjectObj.tasks.length,
                          ),
                          SizedBox(
                            height: size.height > Constant.divSize ? 15 : 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  iconContent(
                                      size: size,
                                      content: widget.byThemProjectObj.price
                                          .toString(),
                                      image: 'assets/icons/Amount.png'),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  iconContent(
                                      size: size,
                                      content: DateFormat('dd-MMM').format(
                                              DateTime.parse(widget
                                                  .byThemProjectObj
                                                  .startDate)) +
                                          ' | ' +
                                          DateFormat('dd-MMM-yyyy').format(
                                              DateTime.parse(widget
                                                  .byThemProjectObj.endDate)),
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
          )
        ],
      ),
    );
  }

  Future<void> _showMyDialog(Size size) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: Color.fromRGBO(37, 36, 41, 1),
          content: Container(
            height: size.height / 1.7,
            width: size.width / 3,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.byThemProjectObj.name,
                    style: TextStyle(
                      color: Constant.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height > Constant.divSize ? 30 : 20,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 45,
                  ),
                  RatingBar(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    // ignoreGestures: true,
                    itemCount: 5,
                    itemSize: 25,
                    unratedColor: Colors.grey,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder: (context, _) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset('assets/icons/selectStar.png'),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: size.height / 3.5,
                    width: size.width / 3 - 25,
                    child: dottedBox(
                      color: Colors.grey,
                      strokeWidth: 2.0,
                      gap: 3.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            // onTap: _submit,
                            child: Container(
                              child: CustomCircleAvatarForIcon(
                                radius:
                                    size.height > Constant.divSize ? 40 : 20,
                                image: 'assets/icons/Acept.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: CustomCircleAvatarForIcon(
                                radius:
                                    size.height > Constant.divSize ? 40 : 20,
                                image: 'assets/icons/Decline.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget dottedBox({color = Colors.black, strokeWidth = 1.0, gap = 5.0}) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(strokeWidth / 2),
        child: CustomPaint(
          painter:
              DashRectPainter(color: color, strokeWidth: strokeWidth, gap: gap),
          child: TextField(
            controller: reviewController,
            maxLines: null,
            style: TextStyle(color: Colors.white54, fontSize: 15),
            decoration: InputDecoration(
                // filled: true,
                isDense: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: "Type something here...",
                hintStyle: TextStyle(color: Colors.white54),
                // fillColor: Colors.grey[850],
                contentPadding: EdgeInsets.all(10)),
          ),
        ),
      ),
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
}
