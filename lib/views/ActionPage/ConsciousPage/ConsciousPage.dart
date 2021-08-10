import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/components/customWidgets/BatteryIndicator.dart';
import 'package:ios_d1/views/ProfilePage/SummaryPage/ConsciousSummaryPage.dart';
import '/components/customWidgets/HeadsetConnector.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/contexts/kColors.dart';
import '/views/ActionPage/ConsciousPage/Circle.dart';
// import 'package:iflow/views/ProfilePage/SummaryPage/ConsciousSummaryPage.dart';

class ConsciousPage extends StatefulWidget {
  final int? progress_time;
  final HeadsetService? headsetService;

  ConsciousPage({this.progress_time,this.headsetService});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ConsciousPageState();
  }
}

class _ConsciousPageState extends State<ConsciousPage> with TickerProviderStateMixin {
  Color color1 = Colors.lightGreenAccent.withOpacity(0.5);
  Color color2 = Colors.red.withOpacity(0.5);
  Color colorBase = Colors.yellowAccent.withOpacity(0.5);
  bool reRender = false;

  Animation<double>? circle1animation;
  AnimationController? circle1Degree;

  Animation<double>? circleDistanceanimation;
  AnimationController? circleDistance;

  double _circle1Angle = 0.0;
  double _circle2Angle = 0.0;
  double _circleDistance = 50;

  List<double> circleDistances = [0.0,0.0];

  //mediatation attention
  int currentMediatationValue = 0;
  int currentAttentionValue = 0;
  int currentWanderingValue = 0;
  int currentBatteryValue = 80;

  List<int> mediatations = [];
  List<int> attentions = [];
  List<int> relaxs = [];
  List<int> wanders = [];
  List<int> wanderThs = [];

  Timer? updater;

  void onSetColorWandering(int value) {
    if (value > 50) {
      print("### case good yellow ");
      setState(() {
        color2 = kColors.gold[500]!.withOpacity(0.5);
      });
    }
    else if ( value <= 50 && value > 30 ) {
      print("### case medium");
      setState(() {
        color2: kColors.orange[200]!.withOpacity(0.5);
      });
    }
    else if (value <= 30) {
      print("### case bad");
      setState(() {
        color2 = kColors.coral[400]!.withOpacity(0.5);
      });
    }
  }

  void onSetColor(double average) {
    if (average > 50) {
      // print("####### case good yellow ");
      setState(() {
        color1 = kColors.yellow[500]!.withOpacity(0.5);
      });
    }
    else if ( average <= 50 && average > 30 ) {
      // print("case medium");
      setState(() {
        color1: kColors.yellow[300]!.withOpacity(0.5);
      });
    }
    else if (average <= 30) {
      // print("case bad");
      setState(() {
        color1 = kColors.green[500]!.withOpacity(0.5);
      });
    }
  }

  void addCircleDistances(double newDistance) {
    setState(() {
      circleDistances[0] = circleDistances[1];
      circleDistances[1] = newDistance;
    });
    print("circle distance ${circleDistances}");
    circleDistance = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    circleDistanceanimation = Tween(begin: circleDistances[0],end:circleDistances[1]).animate(circleDistance!);
    circleDistanceanimation!.addListener(() {
      setState(() {
        _circleDistance = circleDistanceanimation!.value;
      });
    });
    circleDistance!.forward();
  }

  double makeAverage(List<int> nums){
    return nums.reduce((int a, int b) => a + b) / nums.length;
  }

  void onUpdateEEG() async {
    print("on read eeg");
    await widget.headsetService!.useWanderingTh();
    var attention = await widget.headsetService!.readAttention();
    var mediatation = await widget.headsetService!.readMeditation();
    var battery = (await widget.headsetService!.readBattery());
    var wandering = (await widget.headsetService!.readOutput());

    var tx = await widget.headsetService!.readTx();
    // print("attention relax: ${attention}");
    // print("mediatation relax : ${mediatation}");
    print("tx : ${tx}");
    print("wandering index : ${wandering}");
    print("battery : ${battery}");
    setState(() {
      currentMediatationValue = mediatation[0];
      currentAttentionValue = attention[0];
      currentWanderingValue = wandering[0];
      currentBatteryValue = battery[0];
    });
    mediatations.add(mediatation[0]);
    attentions.add(attention[0]);
    wanders.add(wandering[0]);
    wanderThs.add(tx[1]);

    var attentionValue =attention[0];
    var mediatationValue =mediatation[0];
    var _average = (attentionValue+mediatationValue)/2;

    relaxs.add(_average.round());

    // var last2relaxes = relaxs.sublist(relaxs.length-2,relaxs.length);

    var average = _average;

    if (average < 30) {
      addCircleDistances(0);
    }
    else {
      addCircleDistances(min((50/40)*(average-30),50.0));
    }

    print("### average : ${average}");
    onSetColor(average);
    print("### wandering : ${wandering[0]}");
    onSetColorWandering(wandering[0]);

  }

  void startUpdater() {
    onUpdateEEG();
    setState(() {
      updater = Timer.periodic(Duration(seconds: 1), (timer) {
        onUpdateEEG();
      });
    });
  }

  void stopUpdater() {
    stopWandering();
    updater!.cancel();
  }

  void onComplete() {
    print("attentions : ${attentions}");
    print("mediatations: ${mediatations}");
    print("relaxs: ${relaxs}");
    print("wanders : ${wanders}");
    stopWandering();
    updater!.cancel();
    stopUpdater();
    addCircleDistances(0.0);
    var c1 = color1;
    var c2 = color2;
    var cb = colorBase;
    setState(() {
      isComplete = true;
      color1 = Colors.white.withOpacity(0.5);
      color2 = Colors.white.withOpacity(0.5);
      colorBase = Colors.white.withOpacity(0.5);
      Future.delayed(Duration(milliseconds: 200),(){
        showCheck = true;
        color1 = c1;
        color2 = c2;
        colorBase = cb;
      });
    });
  }

  //play-pause ...
  AnimationController? _animationController;
  bool isPlaying = true;
  bool isComplete = false;
  bool showCheck = false;

  var MAX_TIME = null;
  var MAX_WIDTH = null;
  double _width = 20;

  Timer? _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState( () {
        if (seconds < 0) {
          timer.cancel();
        }
        else {
          // print("time ${seconds} ${minutes} ${MAX_TIME} ${MAX_WIDTH}");
          _width = 20.0 + ((2+seconds+minutes*60)/MAX_TIME)*(MAX_WIDTH-20);
          // print('${_width} , ${MAX_WIDTH}');
          seconds = seconds + 1;
          // handleNextFlower();
          // handleNextColor();
          if (1+seconds+minutes*60 > MAX_TIME) {
            // isComplete = true;
            onComplete();
            _timer!.cancel();
          }
          if (seconds > 59) {
            minutes += 1;
            seconds = 0;
            if (minutes > 59) {
              hours += 1;
              minutes = 0;
            }
          }
        }
      },
      ),
    );
  }

  void _handleOnPressed() {
    if (isPlaying) {
      _timer!.cancel();
    }
    if (!isPlaying) {
      startTimer();
    }
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController!.forward()
          : _animationController!.reverse();
    });
  }

  num degreesToRads(num deg) {
    return (deg * pi) / 180.0;
  }

  EdgeInsets positionCalculate({required double distance,required double angle}){
    var _angle = degreesToRads(angle);
    // print("distance : ${distance},angle : ${_angle}, trigo : ${cos(_angle)}");
    double xDistance = distance*cos(_angle);
    double yDistance = distance*sin(_angle);
    // print("xDistance : ${xDistance},yDistance : ${yDistance}");
    double ml = 0.0;
    double mt = 0.0;
    double mr = 0.0;
    double mb = 0.0;
    if (xDistance >= 0) {
      ml = xDistance;
    } else {
      mr = xDistance.abs();
    };
    if (yDistance >= 0) {
      mb = yDistance;
    } else {
      mt = yDistance.abs();
    };
    // print("margin ${ml} ${mt} ${mr} ${mb}");
    return EdgeInsets.fromLTRB(ml, mt, mr, mb);
  }

  void startWandering() {
    widget.headsetService!.useWandering1Minute();
  }

  void stopWandering() {
    widget.headsetService!.useStopWandering();
  }

  void pauseWandering() {
    widget.headsetService!.usePauseWandering();
  }

  void resumeWandering() {
    widget.headsetService!.useResumeWandering();
  }

  @override
  void initState() {
    circle1Degree = AnimationController(duration: Duration(seconds: 5), vsync: this);
    circle1animation = Tween(begin: 0.0,end:360.0).animate(circle1Degree!);
    circle1animation!.addListener(() {      // เพิ่มบรรทัดนี้
      setState(() {                           // เพิ่มบรรทัดนี้
        // print(circle1animation.value);
        _circle1Angle = circle1animation!.value; // เพิ่มบรรทัดนี้
        _circle2Angle = circle1animation!.value + 180.0;
      });                                     // เพิ่มบรรทัดนี้
    });                                       // เพิ่มบรรทัดนี้

    circleDistance = AnimationController(duration: Duration(seconds: 1), vsync: this);
    // circleDistanceanimation = Tween(begin: 50.0,end:0.0).animate(circleDistance);
    circleDistanceanimation = Tween(begin: circleDistances[1],end:circleDistances[0]).animate(circleDistance!);
    circleDistanceanimation!.addListener(() {
      print("circle distance animation : ${circleDistanceanimation!.value}");
      setState(() {
        _circleDistance = circleDistanceanimation!.value;
      });
    });

    // MAX_TIME = widget.progress_time*60;
    if (widget.progress_time == null) {
      MAX_TIME = 1;
    } else MAX_TIME = widget.progress_time!*60;
    // MAX_TIME = 1*60;
    // MAX_TIME = 5;

    this._animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 200));
    _animationController!.forward();

    startTimer();
    startUpdater();
    startWandering();

    super.initState();

    // run animation.
    // circleDistance.repeat(reverse: true);
    circleDistance!.forward();
    circle1Degree!.repeat();
  }

  @override
  void dispose() {
    circle1Degree?.stop();
    circleDistance?.stop();
    _timer!.cancel();
    circle1Degree?.dispose();
    circleDistance?.dispose();

    updater!.cancel();
    stopUpdater();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (MAX_WIDTH == null) {
      setState(() {
        MAX_WIDTH = MediaQuery.of(context).size.width*0.8;
      });
    }

    BoxDecoration background = BoxDecoration(
      // color: Colors.red,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          // Color.fromRGBO(255, 254, 228, 0.5),
          // Color.fromRGBO(245, 219, 169, 1),
          // Color.fromRGBO(229, 238, 191, 0.5)
          color1.withAlpha(10),
          colorBase.withAlpha(50),
          color2.withAlpha(90),
        ],
      ),

    );

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
            decoration: background,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top,),
                BatteryIndicator(batteryHealth: currentBatteryValue),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.45,
                        child: ClipRect(
                          child: Stack(
                            alignment: Alignment.center,
                            // alignment: Alignment.topLeft,
                            children: [
                              Circle(
                                edgeInsets: positionCalculate(distance: _circleDistance*1.5,angle: _circle2Angle),
                                opacity: 0.3,
                                // color1: Color.fromRGBO(255, 136, 48, 1),
                                // color2: Color.fromRGBO(255, 135, 208, 1),
                                // colorBase: Color.fromRGBO(255, 234, 114, 1),
                                color1: color1,
                                color2: color2,
                                colorBase: colorBase,
                              ),
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                              Circle(
                                edgeInsets: positionCalculate(distance: 0,angle: 0),
                                opacity: 0.5,
                                color1: color1,
                                color2: color2,
                                colorBase: colorBase,
                              ),
                              showCheck ? IconButton(
                                iconSize: 128,
                                icon : Icon(Icons.check),
                                onPressed: ()=>{},
                              ) : Container(),
                            ],
                          ),
                        ),
                      ),
                      Container(height: 40,),
                      // Text("Conneted"),
                      Container(height: 32,),
                      Text('${minutes} : ${seconds}', style: TextStyle(fontSize: 24, color: Colors.black54),),
                      Container(height: 16,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  offset: Offset(6, 6),
                                  blurRadius: 6.0,
                                  spreadRadius: 1.0),
                            ]
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)
                              ),
                            ),
                            Positioned(
                                child: AnimatedContainer(
                                  // width: MediaQuery.of(context).size.width*0.8,
                                  width : _width,
                                  duration: Duration(seconds: 1),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end : Alignment.centerRight,
                                        colors : [
                                          Color.fromRGBO(249, 195, 78, 1),
                                          Color.fromRGBO(249, 211, 78, 1),
                                          Color.fromRGBO(252, 234, 122, 1),
                                        ],
                                      )
                                  ),
                                )
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Container(height: 64,),
                // Spacer(flex: 1,),
                AnimatedContainer(
                    height: 64,
                    duration: Duration(milliseconds: 300),
                    width : isComplete ? MediaQuery.of(context).size.width*0.5 : 64,
                    // margin: EdgeInsets.all(48.0),
                    decoration: BoxDecoration(
                      borderRadius: isComplete ? BorderRadius.circular(40):BorderRadius.circular(40),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(254, 234, 122, 1),
                          Color.fromRGBO(250, 202, 78, 1),
                        ],
                      ),
                      shape: isComplete ? BoxShape.rectangle : BoxShape.rectangle,
                    ),
                    child: Center(
                      child: _animationController != null ? isComplete ?
                      InkWell(
                        // onTap: ()=>{
                        //   widget.headsetService?.device.disconnect(),
                        //   Navigator.pushNamed(context, "/conscious-summary",arguments: WanderingSumamryPageArguments(relaxIndexs: relaxs))
                        // },
                        onTap: ()=>{
                          widget.headsetService?.device.disconnect(),
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new ConsciousSummaryPage(
                                  relaxIndexs: relaxs,
                                  wanderingIndexes: wanders,
                                  isSessionComplete: true,
                                  duration: widget.progress_time,
                                  adaptiveTh: wanderThs,
                                )),
                          ),
                        },
                        child: Text("ถัดไป", style: TextStyle(fontSize: 20,color: Colors.black38),),
                      ):
                      IconButton(
                        iconSize: 48,
                        // splashColor: Colors.greenAccent,
                        color: Colors.grey,
                        alignment: Alignment.center,
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          // progress: _animationController,
                          progress: _animationController!,
                        ),
                        onPressed: ()=>_handleOnPressed(),
                      ):
                      Container(),
                    )
                ) ,
              ],
            ),
      ),

    );
  }
}
