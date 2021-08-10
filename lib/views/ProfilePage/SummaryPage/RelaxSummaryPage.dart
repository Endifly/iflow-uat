import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/components/ProfileImage.dart';
import 'package:ios_d1/components/customClass/SessionData.dart';
import 'package:ios_d1/components/customClass/Stat.dart';
import 'package:ios_d1/components/customClass/UseProfile.dart';
import 'package:ios_d1/components/customClass/UserSessions.dart';
import 'package:ios_d1/components/customWidgets/SessionPerformanceIcon.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:ios_d1/services/SessionService.dart';
import 'package:ios_d1/views/ProfilePage/SummaryPage/RelaxSummaryCircle.dart';
import '/components/customWidgets/Typography.dart' as Typo;
import '/components/customWidgets/WhiteButton.dart';
import '/components/icons/MinusIcon.dart';
import '/components/icons/PlusIcon.dart';
import '/views/ActionPage/ConsciousPage/Circle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RelaxSumamryPageArguments {
  final List<int>? relaxIndexs;
  final bool? isSessionComplete;
  final int? duration;

  RelaxSumamryPageArguments({this.relaxIndexs,this.isSessionComplete,this.duration});
}

class RelaxSummaryPage extends StatefulWidget {
  final List<int>? relaxIndexs;
  final bool? isSessionComplete;
  final int? duration;
  // SessionData? sessionData;

  RelaxSummaryPage({this.relaxIndexs,this.isSessionComplete,this.duration});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RelaxSummaryPageState();
  }
}

class _RelaxSummaryPageState extends State<RelaxSummaryPage> {
  String? username = "";
  double? threshold = 60.0;
  String avatarURL = "";
  double relaxRatio = 0.0;
  UseProfile profile = UseProfile();

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

  void _storeIndexes() async {
    SessionServices sv = new SessionServices();
    await sv.initial();

    UserSessions prevUserSessions = UserSessions();
    await prevUserSessions.sync();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username');
    });

    if (prevUserSessions != null) {
      var _th = prefs.getDouble(kPrefs.threshold)?.toInt();
      print("prevUserSessions : ${prevUserSessions.sessions?.length}");
      prevUserSessions.addRelax(widget.relaxIndexs, _th, widget.duration!);
      print("prevUserSessions : ${prevUserSessions.sessions?.length}");
      // await prevUserSessions.save();
      try {
        sv.uploadOneSession(prevUserSessions.localSession!.last);
        print("### upload success");
      } catch(_) {
        print("### upload fail");
        await prevUserSessions.save();
      }
    }
  }

  Future<int> performance() async {
    var relaxIndex = widget.relaxIndexs!;
    var avr = Stat.average(relaxIndex);
    return (avr).toInt();
  }

  Future<int> calculateRelaxRatio() async {
    double threshold = await profile.getThreshold();
    var relaxIndex = widget.relaxIndexs!;
    var relaxCount = relaxIndex.length;
    var overThCount = 0;
    relaxIndex.forEach((i) {
      if (i > threshold) overThCount++;
    });
    return (overThCount*100/relaxCount).toInt();
  }

  Widget getPerformance(int score) {
    if (score <= 45) return Image.asset("assets/images/sun1.png");
    if (score <= 50 && score > 45) return Image.asset("assets/images/sun2.png");
    if (score <= 55 && score > 50) return Image.asset("assets/images/sun3.png");
    if (score > 55) return Image.asset("assets/images/sun4.png");
    return Image.asset("assets/images/sun4.png");
  }

  int getDuration() {
    if (widget.duration == null) return 0;
    if (widget.duration == "") return 0;
    return widget.duration!;
  }


  @override
  void initState() {
    // TODO: implement initState
    if (widget.isSessionComplete!) {
      _storeIndexes();
    }
    print("widget relax : ${widget.relaxIndexs}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          // SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          Center(
            child: RelaxSummaryCircle(),
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
            child: Text("${tr('app.session')} ${tr('app.relax')}", style: TextStyle(
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
                    Text(tr('app.relax'),style:TextStyle(fontSize: 16)),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                            future: calculateRelaxRatio(),
                            builder: (context,snapshot){
                              if (snapshot.hasData) {
                                return Text(snapshot.data.toString(),style: TextStyle(fontSize: 48),);
                              } else {
                                return Text("0",style: TextStyle(fontSize: 48),);
                              }
                            })
                        ,
                        SizedBox(width: 8,),
                        Text("%",textAlign: TextAlign.end,style: TextStyle(fontSize: 22),),
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
                    Text(tr('app.time'),style:TextStyle(fontSize: 16)),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(getDuration().toString(),style: TextStyle(fontSize: 48),),
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
                    Text(tr('app.averageScore')),
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
              SizedBox(width: 20,),
              Container(
                width: 140,
                height: 140,
                padding:EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromRGBO(255, 221, 150, 1),Colors.white],
                    // stops: [0.5,1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: Offset(0.0,5.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tr('app.result'),style:TextStyle(fontSize: 16)),
                    // SizedBox(height: 16,),
                    // Text("Level 2")
                    // Image.asset("assets/images/sun1.png")
                    // FutureBuilder(
                    //     future: performance(),
                    //     builder: (context,AsyncSnapshot<int> snapshot){
                    //       if (snapshot.hasData) {
                    //         return SessionPerformanceIcon(snapshot.data!);
                    //       } else {
                    //         return getPerformance(0);
                    //       }
                    //     })
                    SessionPerformanceIcon(relax: widget.relaxIndexs,),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 32,),
          Container(
              margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
              width: MediaQuery.of(context).size.width*0.6,
              height: 3,
              color : Colors.black12
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Center(
              child: Text(
                "คลายออกจากการจดจ่อ จริงจังเปิดกว้างออกไปมากขึ้น ลดการอยู่กับตัวเองหรือการกดข่มความคิด",
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
                  tr('app.confirm'),
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
      )
    );
  }
}