import 'package:flutter/cupertino.dart';
import 'package:ios_d1/contexts/kColors.dart';

class HomePageCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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

    // TODO: implement build
    return Stack(
      children: [
        FractionalTranslation(
            translation: Offset(0,-0.6),
            child: Transform.scale(
              scale: 2,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.7,
                margin: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage("assets/images/bg1.png"),
                    //   fit: BoxFit.cover,
                    // ),

                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          offset: Offset(0, 1),
                          blurRadius: 12.0,
                          spreadRadius: 1.0),
                    ]
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
        Container(
            child: Center(
              child: Image.asset(
                "assets/images/sun4.png",
                // height: 40,
              ),
            )
        )
      ],
    );
  }

}