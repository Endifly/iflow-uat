import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/components/customClass/SessionData.dart';
import 'package:ios_d1/components/customClass/UserSessions.dart';
import '/components/customWidgets/Typography.dart';

typedef void onpressCallback();

class ResultContainer extends StatelessWidget {

  final onpressCallback? onpress;
  final SessionData? sessionData;

  ResultContainer({this.onpress,this.sessionData});

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

  LinearGradient relaxButtonGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end : Alignment.centerRight,
      colors: [
        Color.fromRGBO(249, 249, 236, 1),
        Color.fromRGBO(249, 235, 168, 1),
        Color.fromRGBO(255, 219, 100, 1),
      ],
      stops: [0.2,0.5,1.0]
  );

  LinearGradient wanderingButtonGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end : Alignment.centerRight,
      colors: [
        Colors.white,
        Color.fromRGBO(233, 234, 238, 1),
      ],
      stops: [0.2,1.0]
  );

  String getLabel() {
    if (sessionData?.type == "relax") return "ผ่อนคลาย";
    return "รู้สึกตัว";
  }

  String getIconPath() {
    if (sessionData?.type == "relax") return "assets/icons/iflow_full.png";
    return "assets/icons/pearl_full.png";
  }

  LinearGradient getBackground() {
    if (sessionData?.type == "relax") return relaxButtonGradient;
    return wanderingButtonGradient;
  }

  String getDate() {
    // print(sessionData?.sessionDate);
    // var s = new  DateTime.
    var initialDate = "1/1/1997 0.00";
    var sd = sessionData?.sessionDate;
    if (sd == null) return initialDate;
    return sd.substring(0,"YYY-MM-DD HH:MM:SS".length+1);
    // return sessionData?.sessionDate ?? "1/1/1997 0.00";
  }

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
              gradient: getBackground(),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(getIconPath()),
                SizedBox(width: 12,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CTypo(text: getLabel(),color:"secondary"),
                    CTypo(text: getDate(),color:"secondary"),
                  ],
                ),
                // SizedBox(width: 12,),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     CTypo(text: "",color:"secondary"),
                //     CTypo(text: "21:00 น.",color:"secondary"),
                //   ],
                // ),
              ],
            )
        ),
      ),
    );
  }

}