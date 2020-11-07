import 'package:flutter/material.dart';
import 'package:login/helpers/dashboard_method.dart';
import 'package:login/helpers/slider/slidericon.dart';
import 'package:login/screens/addproject.dart';
import 'package:provider/provider.dart';

import '../ease_in_widget.dart';

class TopSliderForMobile extends StatefulWidget {
  const TopSliderForMobile({
    Key key,
    @required ScrollController scrollController5,
    @required this.slider,
    @required this.secondSlider,
  })  : _scrollController5 = scrollController5,
        super(key: key);

  final ScrollController _scrollController5;
  final List<SliderIcon> slider, secondSlider;

  @override
  _TopSliderForMobileState createState() => _TopSliderForMobileState();
}

class _TopSliderForMobileState extends State<TopSliderForMobile> {
  SliderIcon _selectedBox;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<DashBoardMethods>(
        builder: (context, dashboardMethods, ch) => Container(
          height: 50,
          width: 480,
          child: ListView.builder(
            controller: widget._scrollController5,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () {
                // Navigator.of(context)
                //     .pushNamed(
                //         '/room-details');
                widget.slider[i % widget.slider.length].title == 'addProject'
                    ? Navigator.of(context).pushNamed(AddProject.routeName)
                    : dashboardMethods.changeDashboardWidget(
                        widget.slider[i % widget.slider.length].title);
                print(dashboardMethods.getDashboardWidgetTag);
                setState(() {
                  if (_selectedBox != null) {
                    _selectedBox.isSelected = false;
                  }
                  if (widget.slider[i % widget.slider.length].title !=
                      'addProject')
                    widget.slider[i % widget.slider.length].isSelected =
                        !widget.slider[i % widget.slider.length].isSelected;
                  _selectedBox = widget.slider[i % widget.slider.length];
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: EaseInWidget(
                  radius: 30,
                  image: widget.slider[i % widget.slider.length].image,
                  secondImage:
                      widget.secondSlider[i % widget.secondSlider.length].image,
                  isSelected:
                      widget.slider[i % widget.slider.length].isSelected,
                  // onTap:
                ),
              ),
            ),
            itemCount: widget.slider.length * 100,
          ),
        ),
      ),
    );
  }
}
