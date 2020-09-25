import 'package:flutter/material.dart';
import 'package:login/helpers/slider/bottomupsliderprovider.dart';
import 'package:provider/provider.dart';
import 'package:login/helpers/constant.dart' as Constant;
import 'ease_in_widget.dart';

class BottomFirstSlider extends StatefulWidget {
  final int selectIndex = 0;
  final size;

  final boxSize;
  ScrollController controller;
  bool isLoading;

  BottomFirstSlider({this.size, this.boxSize, this.controller, this.isLoading});
  @override
  _BottomFirstSliderState createState() => _BottomFirstSliderState();
}

class _BottomFirstSliderState extends State<BottomFirstSlider> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    double screenWidth = MediaQuery.of(context).size.width;
    int select = widget.selectIndex > 0 ? widget.selectIndex : 0;
    widget.controller = ScrollController(
        initialScrollOffset: (3000 + select) * (screenWidth - 40) / 7);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scroll(widget.controller));
    final bottomUpSliderData = Provider.of<BottomUpSliderProvider>(context);
    final bottomUpSlider = bottomUpSliderData.items;
    return GestureDetector(
      onTapCancel: () {
        _scroll(widget.controller);
      },
      onTapUp: (d) {
        _scroll(widget.controller);
      },
      child: Container(
        height: widget.size.height > Constant.divSize ? 100 : widget.boxSize,
        width: widget.size.height > Constant.divSize
            ? widget.size.width
            : widget.size.width,
        child: ListView.builder(
          controller: widget.controller,
          itemExtent: widget.size.width / 9,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, i) => Stack(
            children: <Widget>[
              Padding(
                padding: widget.size.height > Constant.divSize
                    ? EdgeInsets.symmetric(horizontal: 25)
                    : const EdgeInsets.symmetric(horizontal: 0),
                child: EaseInWidget(
                    radius: 30,
                    image: bottomUpSlider[i % bottomUpSlider.length].image,
                    secondImage:
                        bottomUpSlider[i % bottomUpSlider.length].image,
                    onTap: () {
                      print(bottomUpSlider[i % bottomUpSlider.length].image);
                      _scroll(widget.controller);
                    }),
              ),
            ],
          ),
          itemCount: bottomUpSlider.length * 10000,
        ),
      ),
    );
  }

  _scroll(ScrollController controller) {
    final speedFactor = 20;
    double maxExtent2 = controller.position.maxScrollExtent;
    double distanceDifference2 = maxExtent2 - controller.offset;
    double durationDouble2 = distanceDifference2 / speedFactor;
    controller.animateTo(maxExtent2,
        duration: Duration(seconds: durationDouble2.toInt()),
        curve: Curves.linear);
  }
}
