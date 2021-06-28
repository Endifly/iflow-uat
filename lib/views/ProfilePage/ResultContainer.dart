import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/customWidgets/Typography.dart';

typedef void onpressCallback();

class ResultContainer extends StatelessWidget {

  final onpressCallback? onpress;

  ResultContainer({this.onpress});

  List<BoxShadow> neumorphicBoxShahow = [
    BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.3),
        offset: Offset(6, 2),
        blurRadius: 6.0,
        spreadRadius: 1.0),
    BoxShadow(
        color: Color.fromRGBO(255, 255, 255, 0.9),
        offset: Offset(-4, -4),
        blurRadius: 6.0,
        spreadRadius: 4.0)
  ];

  LinearGradient borderGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromRGBO(255, 219, 100, 1),
        Color.fromRGBO(255, 210, 108, 1),
        Color.fromRGBO(255, 219, 100, 1),
      ]);

  LinearGradient buttonGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end : Alignment.centerRight,
      colors: [
        Color.fromRGBO(249, 249, 236, 1),
        Color.fromRGBO(249, 235, 168, 1),
        Color.fromRGBO(255, 219, 100, 1),
      ],
      stops: [0.2,0.5,1.0]
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Container BorderContainer({child}) {
      return Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              gradient: borderGradient,
              boxShadow: neumorphicBoxShahow),
          child : child
      );
    }
    return InkWell(
      onTap: onpress,
      child: BorderContainer(
        child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: buttonGradient,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons/iflow_full.png"),
                SizedBox(width: 12,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CTypo(text: "รู้สึกตัว",color:"secondary"),
                    CTypo(text: "11 / 02 / 2564",color:"secondary"),
                  ],
                ),
                SizedBox(width: 12,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CTypo(text: "",color:"secondary"),
                    CTypo(text: "21:00 น.",color:"secondary"),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }

}