import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(
          color: Color.fromRGBO(251, 243, 204, 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Color.fromRGBO(252, 181, 74, 1),width: 3),
        ),
        child: Image.asset("assets/icons/graph_1.png"),
      ),
    );
  }

}