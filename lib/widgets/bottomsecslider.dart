import 'package:flutter/material.dart';
import 'package:login/helpers/slider/bottomdownsliderprovider.dart';
import 'package:provider/provider.dart';
import 'package:login/helpers/constant.dart' as Constant;

import 'ease_in_widget.dart';

class BottomSecSlider extends StatefulWidget {
  final int selectIndex = 0;
  final size;
  final boxSize;
  ScrollController controller;
  bool isLoading;

  BottomSecSlider({this.size, this.boxSize, this.controller, this.isLoading});
  @override
  _BottomSecSliderState createState() => _BottomSecSliderState();
}

class _BottomSecSliderState extends State<BottomSecSlider> {
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
    final bottomDownIconData = Provider.of<BottomDownSliderProvider>(context);
    final bottomDownSlider = bottomDownIconData.items;
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
          itemExtent: widget.size.width / 9,
          controller: widget.controller,
          scrollDirection: Axis.horizontal,
          reverse: true,
          shrinkWrap: true,
          itemBuilder: (_, i) => Container(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: widget.size.height > Constant.divSize
                      ? EdgeInsets.symmetric(horizontal: 25)
                      : const EdgeInsets.symmetric(horizontal: 0),
                  child: EaseInWidget(
                      radius: 30,
                      image:
                          bottomDownSlider[i % bottomDownSlider.length].image,
                      secondImage:
                          bottomDownSlider[i % bottomDownSlider.length].image,
                      onTap: () {
                        print(bottomDownSlider[i % bottomDownSlider.length]
                            .image);
                        _scroll(widget.controller);
                      }),
                ),
              ],
            ),
          ),
          itemCount: bottomDownSlider.length * 10000,
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
