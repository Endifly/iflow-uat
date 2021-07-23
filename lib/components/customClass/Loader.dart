import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ios_d1/contexts/kColors.dart';

class Loader {
  static SpinKitFadingCircle circleLoader = SpinKitFadingCircle(
    color: kColors.gold[500]!,
    size: 50.0,
  );

  static Widget CircleLoader({show:bool}) {
    if (show) return circleLoader;
    return Container();
  }
}