import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/components/customClass/UserSessions.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import '/components/customWidgets/GraphButton.dart';
import '/views/ProfilePage/SummaryPage/ConsciousGraph.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WanderingSumamryPageArguments {
  final List<int>? relaxIndexs;
  final bool? isSessionComplete;
  final int? duration;

  WanderingSumamryPageArguments({this.relaxIndexs,this.duration,this.isSessionComplete});
}

class ConsciousSummaryPage extends StatefulWidget{
  final List<int>? relaxIndexs;
  final bool? isSessionComplete;
  final int? duration;

  ConsciousSummaryPage({this.relaxIndexs,this.duration,this.isSessionComplete});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ConsciousSummaryPageState();
  }
}

class _ConsciousSummaryPageState extends State<ConsciousSummaryPage> {
  String? username = "";
  double? _threshold = 0.0;


  List<int> mediatations = [];
  List<int> attentions = [];

  double average(List<int> nums){
    return nums.reduce((int a, int b) => a + b) / nums.length;
  }

  void _storeSession() async {
    UserSessions prevUserSessions = UserSessions();
    await prevUserSessions.sync();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username');
    });

    if (prevUserSessions != null) {
      var _th = prefs.getDouble(kPrefs.threshold)?.toInt();
      print("prevUserSessions : ${prevUserSessions.sessions?.length}");
      // prevUserSessions.addWandering(widget.relaxIndexs, _th, widget.duration!);
      prevUserSessions.addWandering(
        du: widget.duration!,
        relax: widget.relaxIndexs,
        th_r: _th,
      );
      print("prevUserSessions : ${prevUserSessions.sessions?.length}");
      await prevUserSessions.save();
    }
  }

  void _setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      _threshold = prefs.getDouble('threshold');
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    _setup();
    print("got relaxs : ${widget.relaxIndexs}");
    if (widget.isSessionComplete!) {
      _storeSession();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // final WanderingSumamryPageArguments args = ModalRoute.of(context)?.settings.arguments as WanderingSumamryPageArguments;
    // print("args : ${args.relaxIndexs}");

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          FractionalTranslation(
                              translation: Offset(0,-0.5),
                              child: Transform.scale(
                                scale: 2,
                                child: Container(
                                  height: MediaQuery.of(context).size.width * 0.7,
                                  margin: EdgeInsets.all(0.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromRGBO(55, 178, 144, 1),
                                        Color.fromRGBO(250, 250, 182, 1),
                                        Color.fromRGBO(250, 250, 182, 1),
                                        Color.fromRGBO(254, 196, 87, 1),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                          ),
                          FractionalTranslation(
                              translation: Offset(0,-0.5),
                              child: Transform.scale(
                                scale: 1.25,
                                child: Container(
                                  height: MediaQuery.of(context).size.width * 0.7,
                                  margin: EdgeInsets.all(0.0),
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      // center: Alignment(-0.8, -0.6),
                                      colors: [
                                        Color.fromRGBO(246, 243, 205, 1),
                                        // Color.fromRGBO(255, 255, 255, 0.4),
                                        Color.fromRGBO(255, 195, 73, 1)
                                      ],
                                      radius: 1.0,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                          ),
                          FractionalTranslation(
                              translation: Offset(0,-0.5),
                              child: Transform.scale(
                                scale: 0.6,
                                child: Container(
                                  height: MediaQuery.of(context).size.width * 0.7,
                                  margin: EdgeInsets.all(0.0),
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      // center: Alignment(-0.8, -0.6),
                                      colors: [
                                        Color.fromRGBO(255, 255, 255, 1),
                                        Color.fromRGBO(255, 255, 255, 1)
                                      ],
                                      radius: 1.0,
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
                    SizedBox(height: 64,),
                    Text(username!, style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),),
                    SizedBox(height: 8,),
                    Text("แบบฝึกหัด รู้สึกตัว", style: TextStyle(
                      fontSize: 20,
                    ),),
                    SizedBox(height: 24,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 128,
                          child: Column(
                            children: [
                              Text("กราฟ",style:TextStyle(fontSize: 16)),
                              SizedBox(height: 16,),
                              GraphButton(onPress: () => Navigator.pushNamed(context, '/conscious-summary-graph',arguments: WanderingGraphArguments(relaxIndexs: widget.relaxIndexs)),),
                              // Container(
                              //   // color: Colors.white,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(24.0),
                              //
                              //       boxShadow: [
                              //         BoxShadow(
                              //             color: Color.fromRGBO(0, 0, 0, 0.1),
                              //             offset: Offset(6, 2),
                              //             blurRadius: 6.0,
                              //             spreadRadius: 3.0),
                              //         BoxShadow(
                              //             color: Color.fromRGBO(255, 255, 255, 0.9),
                              //             offset: Offset(-4, -4),
                              //             blurRadius: 6.0,
                              //             spreadRadius: 4.0)
                              //       ]),
                              //   child: GraphButton(),
                              //   // child : Text("asd")
                              // )
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
                                //   child: Text("${average(args.relaxIndexs!).toStringAsFixed(1)}",style: TextStyle(fontSize: 42),)
                                  child: Text("${average(widget.relaxIndexs!).toStringAsFixed(1)}",style: TextStyle(fontSize: 42),)
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
                    InkWell(
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
                    SizedBox(height: 64,),
                  ],
                ),
              ),
            ],
      ),
    );
  }

}