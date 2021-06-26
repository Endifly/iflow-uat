import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CTypo extends StatelessWidget {
  final String? variant;
  final String text;
  final String? color;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  CTypo({this.variant,required this.text,this.color,this.textStyle,this.textAlign});

  double getFontSize(String? variant) {
    switch(variant) {
      case "h1" :
        return 32;
      case "h2" :
        return 30;
      case "h3" :
        return 28;
      case "h4" :
        return 26;
      case "h5" :
        return 24;
      case "h6" :
        return 24;
      case "body1" :
        return 22;
      case "body2" :
        return 18;
      case "subtitle1" :
        return 16;
      case "subtitle2" :
        return 14;
      case "button" :
        return 10;
      case "caption" :
        return 8;
      default :
        return 16;
    }
  }

  Color getColors(String? variant) {
    switch(variant) {
      case "primary" :
        return Colors.black87;
      case "secondary" :
        return Colors.black54;
      case "error" :
        return Colors.red;
      default :
        return Colors.black87;
    }
  }

  TextStyle getTextStyle() {
    var typoStyle = TextStyle(color: getColors(color), fontSize: getFontSize(variant));
    return typoStyle.merge(textStyle);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(text,style:getTextStyle(),textAlign: textAlign,);
  }
}