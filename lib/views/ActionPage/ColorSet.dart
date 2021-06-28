import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/contexts/kColors.dart';

Color mWhite = Color.fromRGBO(255, 255, 255, 0.5);
Color mPink = Color.fromRGBO(250, 165, 218, 1);
Color mOrange = Color.fromRGBO(254, 127, 18, 1);
Color mBlue = Color(0xff48cae4);
Color mLightBlue = Color(0xffcaf0f8);
Color mGreen = Color(0xff74c69d);

List<List<Color>> relaxColorSets = [
  [
    mWhite,
    Colors.yellow,
    kColors.gold[500]!,
    kColors.yellow[300]!,
    kColors.gold[300]!,
    Colors.yellow,
    mWhite,
  ],
  [
    mWhite,
    Colors.yellow,
    kColors.green[300]!,
    kColors.gold[100]!,
    kColors.green[100]!,
    kColors.gold[300]!,
    mWhite,
  ],
  [
    mWhite,
    mBlue,
    Colors.yellow,
    mGreen,
    mLightBlue,
    kColors.gold[200]!,
    mWhite,
  ],
];