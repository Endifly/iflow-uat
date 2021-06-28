import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Circle extends StatefulWidget {
  final EdgeInsets? edgeInsets;
  final double opacity;

  final Color color1;
  final Color color2;
  final Color colorBase;

  Circle({this.edgeInsets,required this.opacity,required this.colorBase,required this.color1,required this.color2});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CircleState();
  }
}

class _CircleState extends State<Circle> {
  double mx = 0.0;
  double my = 0.0;
  double mOpacity = 0.0;
  Color mColor1 = Colors.white;
  Color mColor2 = Colors.white;
  Color mColorBase = Colors.white;

  void initState() {
    // TODO: implement initState
    setState(() {
      mOpacity = widget.opacity;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Color color1 = Color.fromRGBO(255, 136, 48, 1); //orange
    Color color2 = Color.fromRGBO(255, 135, 208, 1); //pink
    Color colorBase = Color.fromRGBO(255, 234, 114, 1).withOpacity(
        widget.opacity);

    Widget circle1(context) {
      return AnimatedContainer(
        height: MediaQuery
            .of(context)
            .size
            .width * 0.7,
        // margin: EdgeInsets.all(16.0),
        // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.5, -0.5), // near the top right
            radius: 1.8,
            colors: [
              widget.color1.withOpacity(1).withOpacity(widget.opacity), // yellow sun
              colorBase.withOpacity(0), // blue sky
            ],
            stops: [0.1, 0.5],
          ),
          shape: BoxShape.circle,
        ),
        duration: Duration(milliseconds: 500),
      );
    }

    Widget circle2(context) {
      return AnimatedContainer(
        height: MediaQuery
            .of(context)
            .size
            .width * 0.7,
        // margin: EdgeInsets.all(16.0),
        // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.8, 0.6), // near the top right
            radius: 1.8,
            colors: [
              widget.color2.withOpacity(0.7).withOpacity(widget.opacity), // yellow sun
              colorBase.withOpacity(0), // blue sky
            ],
            stops: [0.15, 0.4],
          ),
          shape: BoxShape.circle,
        ),
        duration: Duration(milliseconds: 500),
      );
    }

    Widget circleBase(context) {
      return AnimatedContainer(
        height: MediaQuery
            .of(context)
            .size
            .width * 0.7,
        // margin: EdgeInsets.all(16.0),
        // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
        decoration: BoxDecoration(
          color: widget.colorBase.withOpacity(widget.opacity),
          shape: BoxShape.circle,
        ),
        duration: Duration(milliseconds: 500),
      );
    }

    return
    Container(
      margin: widget.edgeInsets,
      child: Stack(
        alignment: Alignment.center,
        children: [
          circleBase(context),
          circle1(context),
          circle2(context),
        ],
      ),
    );
  }
}
