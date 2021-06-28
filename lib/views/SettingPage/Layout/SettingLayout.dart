import 'package:flutter/cupertino.dart';
import 'package:ios_d1/views/Template/NavLayout.dart';
import '/views/Template/tLayout.dart';

class SettingLayout extends StatelessWidget {
  final Widget? child;

  SettingLayout({this.child});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NavLayout(
      useSafeArea: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(36, 36, 36, 0),
        // height: MediaQuery.of(context).size.height-96,
        child: this.child,
      ),
    );
  }
}