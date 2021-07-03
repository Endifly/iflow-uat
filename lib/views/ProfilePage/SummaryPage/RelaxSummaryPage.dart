import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/components/customClass/SessionData.dart';
import 'package:ios_d1/components/customClass/UserSessions.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import '/components/customWidgets/Typography.dart' as Typo;
import '/components/customWidgets/WhiteButton.dart';
import '/components/icons/MinusIcon.dart';
import '/components/icons/PlusIcon.dart';
import '/views/ActionPage/ConsciousPage/Circle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RelaxSumamryPageArguments {
  final List<int>? relaxIndexs;

  RelaxSumamryPageArguments({this.relaxIndexs});
}

class RelaxSummaryPage extends StatefulWidget {
  final List<int>? relaxIndexs;
  // SessionData? sessionData;

  RelaxSummaryPage({this.relaxIndexs});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RelaxSummaryPageState();
  }
}

class _RelaxSummaryPageState extends State<RelaxSummaryPage> {
  String? username = "";
  double? threshold = 60.0;
  SessionData? sessionData;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  void onIncreseThreshold() {
    setState(() {
      threshold = threshold! + 1;
    });
  }

  void onDecreseThreshold() {
    setState(() {
      threshold = threshold! - 1;
    });
  }

  double average(List<int> nums){
    return nums.reduce((int a, int b) => a + b) / nums.length;
  }

  void saveData(UserSessions _userSessions) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString(kPrefs.userID)!;
    await prefs.setString(userID, jsonEncode(_userSessions));
  }

  void _setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString(kPrefs.userID)!;
    String? userSessionsStore =  prefs.getString(userID);

    print("sesion store : ${userSessionsStore}");

    SessionData newSessionData = SessionData(
        type: 'relax',
        rawSession: widget.relaxIndexs!,
        threshold: prefs.getDouble(kPrefs.threshold)!.toInt(),
    );

    print("created new Session data");

    UserSessions? userSessions;
    var json;
    if (userSessionsStore != null) {
      print("loading user session");
      json = jsonDecode(userSessionsStore);
      userSessions = UserSessions.fromJson(json);
      print("loaded user session : ${userSessions.userID} ${userSessions.sessions}");
    }


    setState(() {
      username = prefs.getString('username');
    });

    sessionData = SessionData(
      type: 'relax',
      rawSession: widget.relaxIndexs!,
      threshold: prefs.getDouble(kPrefs.threshold)!.toInt(),
    );

    if (userSessions != null) {
      userSessions.addSession('relax', widget.relaxIndexs, prefs.getDouble(kPrefs.threshold)?.toInt());
      print("add to old user sesion ${userSessions.sessions}");
      saveData(userSessions);
    } else {
      UserSessions newUserSession = UserSessions(
          userID: prefs.getString(kPrefs.userID)!,
          sessions: [newSessionData],
      );
      print("add to new user sesion ${newUserSession.sessions.length}");
      saveData(newUserSession);
    }

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
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            Center(
              child: Container(
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
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                  spreadRadius: 2.0,
                                  blurRadius: 8.0,
                                  offset: Offset(0,0),
                                )
                              ],
                              gradient: RadialGradient(
                                // center: const Alignment(0.8, 0.6), // near the top right
                                radius: 1.0,
                                colors: [
                                  Color.fromRGBO(255, 182, 77, 1), // yellow sun
                                  Color.fromRGBO(255, 228, 128, 1)
                                ],
                                stops: [0.15, 0.4],
                              ),
                              shape: BoxShape.circle,
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
                          scale: 0.7,
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.7,
                            margin: EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image : AssetImage("assets/images/person_2.png"),
                                // fit: BoxFit.cove,
                              ),
                              color : Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 64,),
            Center(
              child: Text(username!, style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
              ),
            ),
            SizedBox(height: 8,),
            Center(
              child: Text("แบบฝึกหัด รู้สึกตัว", style: TextStyle(
                fontSize: 20,
              ),
              ),
            ),
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 128,
                  child: Column(
                    children: [
                      Text("สภาวะโพร่ง",style:TextStyle(fontSize: 16)),
                      SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("14",style: TextStyle(fontSize: 48),),
                          SizedBox(width: 8,),
                          Text("ครั้ง",textAlign: TextAlign.end,),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 32,),
                Container(
                  color : Colors.orange,
                  height: 128,
                  width: 2,
                ),
                SizedBox(width: 32,),
                SizedBox(
                  width: 128,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("เวลา",style:TextStyle(fontSize: 16)),
                      SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("1",style: TextStyle(fontSize: 48),),
                          SizedBox(width: 8,),
                          Text("นาที",textAlign: TextAlign.end,),
                        ],
                      ),
                      SizedBox(height: 40,),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 128,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("คะแนนเฉลี่ย"),
                      SizedBox(height: 8,),
                      Container(
                        // color: Colors.white,
                          child: Text(average(widget.relaxIndexs!).toStringAsFixed(1),style: TextStyle(fontSize: 48),)
                        // child : Text("asd")
                      )
                    ],
                  ),
                ),
                SizedBox(width: 32,),
                Container(
                  color : Colors.orange,
                  height: 128,
                  width: 2,
                ),
                SizedBox(width: 32,),
                SizedBox(
                  width: 128,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ผลการประเมิณ",style:TextStyle(fontSize: 16)),
                      SizedBox(height: 16,),
                      Text("Level 2")
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 32,),
            Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: 3,
                color : Colors.black12
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
              child: Center(
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque imperdiet turpis et mollis consectetur.",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/home'),
                child: Container(
                  padding: EdgeInsets.all(8),
                  width : MediaQuery.of(context).size.width*0.5,
                  child: Text(
                    "ตกลง",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0XFFEFF3F6),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color.fromRGBO(255, 204, 79, 1), Color.fromRGBO(255, 174, 64, 1)]),
                      borderRadius: BorderRadius.circular(100.0),
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
                      ]),
                ),
              ),
            ),
            SizedBox(height: 16,),
          ],
        ),
      ),
    );
  }
}