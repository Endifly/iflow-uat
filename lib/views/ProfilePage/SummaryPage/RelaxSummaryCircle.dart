import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/components/customClass/UseProfile.dart';
import 'package:ios_d1/components/ProfileImage.dart';
import 'package:ios_d1/contexts/kColors.dart';

class RelaxSummaryCircle extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RelaxSummaryCircleState();
  }

}

class RelaxSummaryCircleState extends State<RelaxSummaryCircle> {

  UseProfile profile = UseProfile();

  Color color1 = Color.fromRGBO(255, 136, 48, 1); //orange
  Color color2 = kColors.green[300]!; //pink
  Color colorBase = Color.fromRGBO(255, 234, 114, 1);

  Widget circle1(context) {
    return AnimatedContainer(
      // margin: EdgeInsets.all(16.0),
      // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.5, -0.5), // near the top right
          radius: 2.5,
          colors: [
            color1.withOpacity(1).withOpacity(0.8), // yellow sun
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
      // margin: EdgeInsets.all(16.0),
      // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.5, 0.5), // near the top right
          radius: 1.5,
          colors: [
            color2.withOpacity(0.7).withOpacity(0.8), // yellow sun
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
      // margin: EdgeInsets.all(16.0),
      // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
      decoration: BoxDecoration(
        color: colorBase.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Stack(
        children: [
          FractionalTranslation(
              translation: Offset(0,-0.5),
              child: Transform.scale(
                scale: 2,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7,
                  // margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                        colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
                        image: new AssetImage("assets/images/flower5.png")
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        spreadRadius: 2.0,
                        blurRadius: 8.0,
                        offset: Offset(0,0),
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(255,255,255, 1),
                        spreadRadius: 0.0,
                        blurRadius: 0.0,
                        offset: Offset(0,0),
                      )
                    ],
                    // gradient: RadialGradient(
                    //   // center: const Alignment(0.8, 0.6), // near the top right
                    //   radius: 1.0,
                    //   colors: [
                    //     Color.fromRGBO(255, 182, 77, 1), // yellow sun
                    //     Color.fromRGBO(255, 228, 128, 1)
                    //   ],
                    //   stops: [0.15, 0.4],
                    // ),
                    shape: BoxShape.circle,

                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      circleBase(context),
                      circle1(context),
                      circle2(context),
                    ],
                  ),
                ),
              )
          ),
          FractionalTranslation(
              translation: Offset(0,0.3),
              child: Transform.scale(
                scale: 0.75,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.7,
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color : Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              )
          ),
          FractionalTranslation(
              translation: Offset(0,0.3),
              child: Transform.scale(
                scale: 1.0,
                child: FutureBuilder(
                  future: profile.getAvatarURL(),
                  builder: (context,AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return ProfileImage(imagePath: snapshot.data!);
                    }
                    return Container();
                  },
                ),
              )
          ),
        ],
      ),
    );
  }

}