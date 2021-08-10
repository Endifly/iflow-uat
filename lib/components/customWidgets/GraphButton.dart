import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/contexts/kColors.dart';

typedef void onPressCallback();

class GraphButton extends StatelessWidget {

  final onPressCallback? onPress;
  GraphButton({this.onPress});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return InkWell(
      onTap: onPress,
      child: Container(
        // height: 140,
        // width: 140,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   // colors: [Color.fromRGBO(255, 221, 150, 1),Colors.white],
          //   // stops: [0.5,1.0],
          //   // begin: Alignment.topCenter,
          //   // end: Alignment.bottomCenter,
          // ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.2),
          //     blurRadius: 12,
          //     spreadRadius: 2,
          //     offset: Offset(0.0,5.0),
          //   )
          // ],
          // borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset("assets/icons/graph_1.png"),
      ),
    );
  }

}