import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/components/customWidgets/Typography.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:ios_d1/views/HomePage/HomePageCircle.dart';
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
  String? avatarURL = "";
  String fullname = "";

  void _setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role')!;
      fullname = '${prefs.getString(kPrefs.firstname)!} ${prefs.getString(kPrefs.lastname)!}';
      avatarURL = prefs.getString(kPrefs.avatarURL);
    });
  }

  DecorationImage getAvatar(String? avatarUrl) {
    print("home ${avatarUrl}");
    var defaultProfile = DecorationImage(image : AssetImage("assets/images/person_2.png"),);
    if (avatarUrl == null) return defaultProfile;
    if (avatarUrl == "") return defaultProfile;
    if (avatarUrl.startsWith('http')) return DecorationImage(image: NetworkImage(avatarUrl,),fit: BoxFit.fill);
    return DecorationImage(image : AssetImage("assets/images/person_2.png"),);
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
                  HomePageCircle(),
                  SizedBox(height: 16,),
                  Container(
                    margin: EdgeInsets.fromLTRB(56, 0, 56, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 72,
                              width: 72,
                              margin: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                image: getAvatar(this.avatarURL),
                                color : Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CTypo(text:this.fullname,variant: "body2",),
                                CTypo(text:this.role,variant: "subtitle1",)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 32,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 16,),
                            CTypo(text: tr("app.selectSession"),color:"secondary",variant: 'body2',),
                          ],
                        ),
                        SizedBox(height: 32,),
                        RelaxButton(),
                        SizedBox(height: 32,),
                        WanderingButton(),
                      ],
                    ),
                  )
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
        width: MediaQuery.of(context).size.width,
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
                  tr('app.wandering'),
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



  @override
  Widget build(BuildContext context) {

    final CONCAVE_SHADOW = ConcaveDecoration(shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        depression: 3);

    Decoration NORMAL_BUTTON = BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.15,0.35,0.6,1.0],
            colors: [
              Color.fromRGBO(252, 223, 117, 1).withOpacity(0.5),
              Color.fromRGBO(250, 250, 240, 1),
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
          Color.fromRGBO(252, 223, 117, 1),
          Color.fromRGBO(250, 250, 240, 1),
          Color.fromRGBO(252, 223, 117, 1),
          Color.fromRGBO(255, 219, 100, 1),
        ],
      ),
    );

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
      width: MediaQuery.of(context).size.width,
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
                tr('app.relax'),
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