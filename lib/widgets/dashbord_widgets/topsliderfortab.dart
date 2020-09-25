import 'package:flutter/material.dart';
import 'package:login/helpers/slider/slidericon.dart';
import 'package:login/screens/roomdetails.dart';
import 'package:login/helpers/constant.dart' as Constant;
import '../ease_in_widget.dart';

class TopSliderForTab extends StatelessWidget {
  const TopSliderForTab({
    Key key,
    @required this.size,
    @required this.slider,
  }) : super(key: key);

  final Size size;
  final List<SliderIcon> slider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size.height > Constant.divSize ? 80 : 40,
        width: size.height > Constant.divSize ? 550 : 100,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: EaseInWidget(
                  radius: 30,
                  image: slider[i % slider.length].image,
                  secondImage: slider[i % slider.length].image,
                  onTap: () {
                    Navigator.of(context).pushNamed(RoomDetails.routeName);
                    print("Hello");
                  })),
          itemCount: slider.length * 100,
        ),
      ),
    );
  }
}
