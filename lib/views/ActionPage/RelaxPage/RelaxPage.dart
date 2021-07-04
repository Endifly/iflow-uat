import 'dart:async';
import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/views/ProfilePage/SummaryPage/RelaxSummaryPage.dart';

import '/components/customWidgets/HeadsetConnector.dart';
import '/views/ActionPage/ColorSet.dart';
import '/views/ActionPage/RelaxPage/Flower.dart';
// import '/views/ProfilePage/SummaryPage/RelaxSummaryPage.dart';

class RelaxPage extends StatefulWidget {
  // final BluetoothDevice server;
  final int? progress_time;
  final HeadsetService? headsetService;

  const RelaxPage({
    // this.server,
    this.progress_time,
    this.headsetService,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RelaxPageState();
  }
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _RelaxPageState extends State<RelaxPage> with TickerProviderStateMixin {
  //mediatation attention
  int currentMediatationValue = 0;
  int currentAttentionValue = 0;
  double threshold = 60.0;

  final assetsAudioPlayer = AssetsAudioPlayer();

  List<int> mediatations = [];
  List<int> attentions = [];
  List<int> relaxes = [];
  List<double> rotateAngle = [0.0,0.0];

  //play-pause ...
  AnimationController? _animationController;
  bool isPlaying = true;
  bool isComplete = false;

  //flower ...
  var flower_state = 0;
  AnimationController? rotationController;
  Animation<double>? rotateAnimation;
  double _rotateAngle = 0.0;
  //flowerBackground ...
  var flowerBackgroundState = 0;

  //timing ...
  var MAX_TIME = null;
  var MAX_WIDTH = null;
  double _width = 20;
  Timer? updater;
  int slowFactor = 2;

  void addRotate(double newDistance) {
    setState(() {
      rotateAngle[0] = rotateAngle[1];
      rotateAngle[1] = newDistance;
    });
    print("circle distance ${rotateAngle}");
    rotationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    rotateAnimation = Tween(begin: rotateAngle[0],end:rotateAngle[1]).animate(rotationController!);
    rotateAnimation!.addListener(() {
      setState(() {
        _rotateAngle = rotateAnimation!.value;
      });
    });
    rotationController!.forward();
  }

  void onPlaySound(double average) {
    if (average > threshold) {
      assetsAudioPlayer.play();
    }
  }

  double makeAverage(List<int> nums){
    return nums.reduce((int a, int b) => a + b) / nums.length;
  }

  void onUpdateEEG() async {
    print("on read eeg");
    var attention = await widget.headsetService!.readAttention();
    var mediatation = await widget.headsetService!.readMeditation();
    print("attention relax: ${attention}");
    print("mediatation relax : ${mediatation}");
    setState(() {
      currentMediatationValue = mediatation[0];
      currentAttentionValue = attention[0];
    });
    mediatations.add(mediatation[0]);
    attentions.add(attention[0]);

    var attentionValue = attention[0];
    var mediatationValue = mediatation[0];
    var average = (attentionValue+mediatationValue)/2;

    relaxes.add(average.round());

    // var last3relaxes = relaxes.sublist(relaxes.length-2,relaxes.length);

    print("relax average : ${average}");
    // addRotate(makeAverage(last3relaxes)/100-0.75);
    addRotate(average/100-0.75);
    updateRingColor(average);
    // updateRingColor(makeAverage(last3relaxes));
    updateFlowerSpeed(average);
    onPlaySound(average);
    // updateFlowerSpeed(makeAverage(last3relaxes));
  }

  void startUpdater() {
    setState(() {
      updater = Timer.periodic(Duration(seconds: 1), (timer) {
        onUpdateEEG();
      });
    });
  }

  void stopUpdater() {
    updater!.cancel();
  }

  //bluetooth ...
  static final clientID = 0;
  String poorQuality = "200";
  // BluetoothConnection connection;

  // List<_Message> messages = List<_Message>();
  // String _messageBuffer = '';

  // bool isConnecting = true;
  // bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  void handleNextFlower() {
    var average = (currentMediatationValue+currentAttentionValue)/2;
    if (average < 20) return;
    flower_state = flower_state+1;
    if (flower_state == 8) {
      setState(() {
        flower_state = 0;
      });
    }
  }


  void updateFlowerSpeed(double average) {
    if (average >= 70) {
      setState(() {
        slowFactor = 2;
        print("slow factor : 2");
      });
    } else {
      setState(() {
        // slowFactor = ( 5-((3/70)*(average-30)) ).round();
        slowFactor = ( 5 - ((3/70)*(average)) ).round();
        print("slow factor : ${( 5 - ((3/70)*(average)) ).round()}");
      });
    }
  }

  void updateRingColor(double average) {
    if (average > 50) {
      setState(() {
        flowerBackgroundState = 0;
      });
    }
    else if (average > 40) {
      setState(() {
        flowerBackgroundState = 1;
      });
    }
    else {
      setState(() {
        flowerBackgroundState = 2;
      });
    }
  }

  // void handleNextColor() {
  //   if (seconds%3 == 0) {
  //     // print(relaxColorSets);
  //     // print("color set : ${(flowerBackgroundState+1)%relaxColorSets.length}");
  //     setState(() {
  //       flowerBackgroundState = (flowerBackgroundState+1)%relaxColorSets.length;
  //     });
  //   }
  // }

  void onComplete() {
    print("attentions : ${attentions}");
    print("mediatations: ${mediatations}");
    updater?.cancel();
    stopUpdater();
  }

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
          _width = 20.0 + ((2+seconds+minutes*60)/MAX_TIME)*(MAX_WIDTH-20);
          // print('${_width} , ${MAX_WIDTH}');
          seconds = seconds + 1;
          if (seconds%slowFactor ==0) {handleNextFlower();}
          // handleNextColor();
          if (1+seconds+minutes*60 > MAX_TIME) {
            isComplete = true;
            onComplete();
            _timer?.cancel();
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
      _timer?.cancel();
    }
    if (!isPlaying) {
      startTimer();
    }
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController?.forward()
          : _animationController?.reverse();
    });
  }




  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.open(Audio("assets/sounds/gong.mp3"));
    rotationController = AnimationController(duration: const Duration(seconds: 30), vsync: this);
    rotationController?.repeat(reverse: true);

    // MAX_TIME = widget.progress_time!*60;
    MAX_TIME = 10;

    this._animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 200));
    _animationController?.forward();

    startTimer();
    startUpdater();
  }

  void disConnectDevice() {
    print("disconnect");
    widget.headsetService!.device.disconnect();
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    // if (isConnected) {
    //   isDisconnecting = true;
    //   connection.dispose();
    //   connection = null;
    // }
    updater?.cancel();
    stopUpdater();
    disConnectDevice();
    _timer?.cancel();
    super.dispose();
  }

  void _onDataReceived(Uint8List data) {

    bool found32 = false;
    bool foundPoor = false;
    int poor_quality = 0;
    int attention = 0;
    int meditation = 0;
    int blink = 0;
    // print(data);

    if (data.contains(170) && data.contains(32) && data.contains(2) ) {
      print(data);
      data.forEach((element) {
        if (foundPoor) {
          setState(() {
            poorQuality = element.toString();
            found32 = false;
            foundPoor = false;
          });
        }
        else if (found32 && element ==2) {
          foundPoor = true;
        }
        else if (element == 32) {
          found32 = true;
        }
        else {
          found32 = false;
          foundPoor = false;
        }
      });
    }

    // data.forEach((byte) {
    //   // print(SYNC);
    //   print(byte);
    // });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    // print("relax");
    // print(arguments);
    if (MAX_WIDTH == null) {
      setState(() {
        MAX_WIDTH = MediaQuery.of(context).size.width*0.8;
      });
    }

    Widget ColorRing() {
      return AnimatedContainer(
        duration: Duration(seconds: 1),
        height: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.all(48.0),
        decoration: BoxDecoration(
          gradient: SweepGradient(
            colors: relaxColorSets[flowerBackgroundState],
          ),
          shape: BoxShape.circle,
        ),
        // transform: (Matrix4.identity()
        // ..rotateZ(40)
        // ),
      );
    }

    Widget renderButton(context) {
      if (_animationController == null) return Container();
      if (isComplete) return
        InkWell(
          onTap: ()=>{
            widget.headsetService?.device.disconnect(),
            Navigator.push(
            context,
            new MaterialPageRoute(
            builder: (context) => new RelaxSummaryPage(relaxIndexs: relaxes,isSessionComplete: true,)),
            ),
          },
          child: Text("ถัดไป", style: TextStyle(fontSize: 20,color: Colors.black38),),
        );
      return
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
        );
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                // color: Colors.red,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Color.fromRGBO(233, 234, 238, 1)]
                  )
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()=>handleNextFlower(),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              rotateAnimation != null ?
                              RotationTransition(
                                  turns: rotateAnimation!,
                                child: ColorRing(),
                              )
                              :
                              ColorRing()
                              ,
                              Container(
                                height: MediaQuery.of(context).size.width * 0.8 - 40,
                                margin: EdgeInsets.all(48.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              isComplete ? IconButton(
                                iconSize: 128,
                                icon : Icon(Icons.check),
                                onPressed: ()=>{},
                              ) :
                              Flower(flowerState: flower_state,slowFactor: slowFactor,),
                            ],
                          ),
                        ),
                        Text("Connected"),
                        Text(poorQuality),
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
                        child: renderButton(context),
                      )
                  ) ,
                  SizedBox(height: 16,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

