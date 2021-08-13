import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/components/customClass/Stat.dart';
import 'package:ios_d1/contexts/kColors.dart';

class HomePageCircle  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageCircleState();
  }

}

class _HomePageCircleState extends State<HomePageCircle> with SingleTickerProviderStateMixin {

  // double? heroOffset;
  // Animation<double>? heroOffsetAnimation;
  // AnimationController? heroOffsetController;
  CircleColor colorName = CircleColor.sun4;
  String assetPath = "assets/images/sun4.png";

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -1.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  void changeBg() {
    print("Change bg : ${colorName}");
    if (this.colorName == CircleColor.sun4) setState(() {
      this.colorName = CircleColor.cloud3;
    });
    else if (this.colorName == CircleColor.cloud3) setState(() {
      this.colorName = CircleColor.sun4;
    });
  }

  void swapAsset() {
    setState(() {
      this.assetPath = "assets/images/sun1.png";
    });
  }

  void swapHero() {
    // _controller.forward();
    _controller.forward().then((x) => {
      changeBg(),
      swapAsset(),
      _controller.reverse()
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.swapHero();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    HomePageCircleColorSet CS = HomePageCircleColorSet();
    //
    // Color color1 = Color.fromRGBO(255, 163, 221, 1); //orange
    // Color color2 = Color.fromRGBO(255,114,9, 1); //pink
    // Color color3 = Colors.white; //pink
    // Color colorBase = Color.fromRGBO(254,244,153, 1);

    void openDescription() {
      Navigator.pushNamed(context, '/home/herodesc');
    }

    Widget circle1(context) {
      return AnimatedContainer(
        // margin: EdgeInsets.all(16.0),
        // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(-0.25, -0.25), // near the top right
            radius: 1.5,
            colors: [
              CS.colorSet(colorName).color1.withOpacity(1), // yellow sun
              CS.colorSet(colorName).colorBase.withOpacity(0), // blue sky
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
              CS.colorSet(colorName).color2.withOpacity(0.7).withOpacity(0.5), // yellow sun
              CS.colorSet(colorName).colorBase.withOpacity(0), // blue sky
            ],
            stops: [0.15, 0.4],
          ),
          shape: BoxShape.circle,
        ),
        duration: Duration(milliseconds: 500),
      );
    }

    Widget circle3(context) {
      return AnimatedContainer(
        // margin: EdgeInsets.all(16.0),
        // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.15, -0.25), // near the top right
            radius: 0.6,
            colors: [
              CS.colorSet(colorName).color3.withOpacity(1), // yellow sun
              CS.colorSet(colorName).colorBase.withOpacity(0), // blue sky
            ],
            stops: [0.1, 0.5],
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
          color: CS.colorSet(colorName).colorBase.withOpacity(1),
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
                    circle3(context),
                  ],
                ),
              ),
            )
        ),

        Center(
          child: SlideTransition(
            position: _offsetAnimation,
            child: InkWell(
              onTap : ()=>{openDescription()},
              child: Hero(
                tag : 'dash',
                child: Image.asset(assetPath),
              ),
            ),
          ),
        )
      ],
    );
  }
}

// class CircleColorName {
//   static const String cloud3 = "cloud3";
//   static const String sun4 = "sun4";
// }
enum CircleColor {
  sun4,
  cloud3
}

class _ColorSet {
  Color color1;
  Color color2;
  Color color3;
  Color colorBase;

  _ColorSet({required this.colorBase,required this.color1,required this.color2,required this.color3});
}

class HomePageCircleColorSet {

  HomePageCircleColorSet();

  _ColorSet cloud3 = _ColorSet(
      colorBase: Color.fromRGBO(254,244,153, 1),
      color1: Color.fromRGBO(255,199,111, 1),
      color2: Color.fromRGBO(153,211,185, 1),
      color3: Color.fromRGBO(244,163,68,1)
  );

  _ColorSet sun4 = _ColorSet(
      colorBase: Color.fromRGBO(254,244,153, 1),
      color1: Color.fromRGBO(255, 163, 221, 1),
      color2: Color.fromRGBO(255,114,9, 1),
      color3: Colors.white
  );

  _ColorSet colorSet(CircleColor name) {
    if (name == CircleColor.sun4) return this.sun4;
    if (name == CircleColor.cloud3) return this.cloud3;
    return this.sun4;
  }

}