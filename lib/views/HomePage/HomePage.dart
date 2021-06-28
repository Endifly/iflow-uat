import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/views/Template/NavLayout.dart';
import '/components/ButtonNavigationBar.dart';
import '/components/DecorationConcave.dart';
import '/contexts/kColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  String role = "";

  void _setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role')!;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    _setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NavLayout(
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color.fromRGBO(233, 234, 238, 1),
              ]),
        ),
        child:Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(),
                  SizedBox(height: 32,),
                  RelaxButton(),
                  SizedBox(height: 32,),
                  WanderingButton(),
                ],
              ),
            ),
          ],
        ),
        useSafeArea: false);
  }
}

class WanderingButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WanderingButtonState();
  }

}

class _WanderingButtonState extends State<WanderingButton> {
  bool isPress = false;

  final CONCAVE_SHADOW = ConcaveDecoration(shape:
  RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      depression: 3);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    void toConcious() {
      Navigator.pushNamed(context, "/start-conscious");
    }

    void onPressDown(pd) {
      setState(() {
        isPress = true;
      });
    }

    void onPressUp(pu) {
      setState(() {
        isPress = false;
      });
      toConcious();
    }

    Decoration NORMAL_BUTTON = BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              kColors.yellow[400]!,
              Color.fromRGBO(252, 171, 63, 1),
            ]),
        boxShadow: [
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
        ]
    );

    BoxDecoration BORDER_COLOR = BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kColors.gold[500]!,
              kColors.gold[300]!,
            ]),
        boxShadow: [
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
        ]
    );

    BoxDecoration BACKGROUND_COLOR = BoxDecoration(
      borderRadius: BorderRadius.circular(40.0),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kColors.yellow[500]!, Colors.orangeAccent]),
    );

    return Container(
        padding: EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: isPress ? BACKGROUND_COLOR:BORDER_COLOR,
        child: Listener(
          onPointerDown: onPressDown,
          onPointerUp: onPressUp,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.all(8),
            decoration: isPress ? CONCAVE_SHADOW : NORMAL_BUTTON,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "รู้สึกตัว",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black38,
                    fontFamily: "Prompt",
                    fontSize: 20,
                  ),
                ),
                Positioned(
                  left: 0,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/icons/pearl_full.png",
                      height: 40,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

}

class RelaxButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RelaxButtonState();
  }

}

class _RelaxButtonState extends State<RelaxButton> {
  bool isPress = false;

  final CONCAVE_SHADOW = ConcaveDecoration(shape:
  RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      depression: 3);

  Decoration NORMAL_BUTTON = BoxDecoration(
      borderRadius: BorderRadius.circular(40.0),
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(250, 250, 240, 1),
            Color.fromRGBO(246, 245, 211, 1),
            Color.fromRGBO(252, 223, 117, 1),
            Color.fromRGBO(255, 219, 100, 1),
          ]),
      boxShadow: [
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
      ]
  );

  BoxDecoration BORDER_COLOR = BoxDecoration(
      borderRadius: BorderRadius.circular(40.0),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kColors.gold[500]!,
            kColors.gold[300]!,
          ]),
      boxShadow: [
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
      ]
  );

  BoxDecoration BACKGROUND_COLOR = BoxDecoration(
    borderRadius: BorderRadius.circular(40.0),
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromRGBO(250, 250, 240, 1),
          Color.fromRGBO(246, 245, 211, 1),
          Color.fromRGBO(252, 223, 117, 1),
          Color.fromRGBO(255, 219, 100, 1),
        ],
    ),
  );

  @override
  Widget build(BuildContext context) {

    void toRelax() {
      Navigator.pushNamed(context, "/start");
    }

    void onPressDown(pd) {
      setState(() {
        isPress = true;
      });
    }

    void onPressUp(pu) {
      setState(() {
        isPress = false;
      });
      toRelax();
    }

    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(2),
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: isPress ? BACKGROUND_COLOR:BORDER_COLOR,
      child: Listener(
        onPointerUp: onPressUp,
        onPointerDown: onPressDown,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: EdgeInsets.all(8),
          decoration: isPress ? CONCAVE_SHADOW : NORMAL_BUTTON,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "ผ่อนคลาย",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black38,
                  fontFamily: "Prompt",
                  fontSize: 20,
                ),
              ),
              Positioned(
                left: 0,
                child: ClipOval(
                  child: Image.asset(
                    "assets/icons/iflow_full.png",
                    height: 40,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class Hero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg1.png"),
                    fit: BoxFit.cover,
                  ),

                  shape: BoxShape.circle,
                    boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        offset: Offset(0, 1),
                        blurRadius: 12.0,
                        spreadRadius: 1.0),
                  ]
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