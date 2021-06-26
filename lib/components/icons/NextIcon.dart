import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef void OnPressCallback();

class NextIcon extends StatelessWidget {
  final OnPressCallback? onPress;

  NextIcon({this.onPress});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(252, 171, 63, 1),
              Color.fromRGBO(250, 202, 78, 1),
            ],
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(0, 2),
                blurRadius: 3.0,
                spreadRadius: 3.0
            ),
          ],
          shape: BoxShape.circle,
        ),
        child: Container(
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: FaIcon(FontAwesomeIcons.angleRight),
        ),
      ),
    );
  }

}