import 'package:flutter/material.dart';

class EaseInWidget extends StatefulWidget {
  final Function onTap;
  const EaseInWidget({Key key, @required this.onTap}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _EaseInWidgetState();
}

class _EaseInWidgetState extends State<EaseInWidget>
    with TickerProviderStateMixin<EaseInWidget> {
  AnimationController controller;
  Animation<double> easeInAnimation;
  bool _selected = false;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      value: 0.1,
    );
    easeInAnimation = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) async {
        if (widget.onTap == null) {
          return;
        }
        setState(() {
          _selected = true;
        });
        await controller.forward().then((val) {});
      },
      onTapUp: (TapUpDetails details) async {
        if (widget.onTap == null) {
          return;
        }
        await controller.reverse().then((val) {
          widget.onTap();
        });
        setState(() {
          _selected = false;
        });
      },
      onTapCancel: () async {
        await controller.forward().then((val) {
          controller.reverse().then((val) {
            widget.onTap();
          });
        });
        setState(() {
          _selected = false;
        });
      },
      child: ScaleTransition(
        scale: easeInAnimation,
        child: Material(
          child: CircleAvatar(
            radius: 40,
            backgroundColor: _selected ? Colors.yellow : Colors.purple,
            child: Image.asset(
              _selected ? 'image/unnam.png' : 'image/unnamed.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
