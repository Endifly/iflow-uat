import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '/components/ButtonNavigationBar.dart';
import '/components/customWidgets/HeadsetConnector.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/VolumeButton.dart';
import '/components/customWidgets/WhiteButton.dart';
import '/views/ActionPage/ConsciousPage/ConsciousPage.dart';

class StartConsciousPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StartConsciousPageState();
  }
}

class _StartConsciousPageState extends State<StartConsciousPage> {

  var loadingValue = null;
  HeadsetService? headsetService;
  final List<int> timing = [1,3,5,10];
  List<BluetoothDevice>? devices;
  BluetoothDevice? selectedDevice;

  var current_time_selection = 1;

  void onTimeChange(int index) {
    setState(() {
      current_time_selection = timing[index];
    });
  }

  FlutterBlue flutterBlue = FlutterBlue.instance;

  void onLoadSuccess() {
    setState(() {
      loadingValue = 100.0;
    });
  }

  void onConnected(HeadsetService _headsetService) {
    print("got headset @ wandering : ${_headsetService}");
    onLoadSuccess();
    setState(() {
      headsetService = _headsetService;
    });
  }

  List<Widget> time_selection() {
    return timing.map((time) => Container(
      child: Text('${time} นาที', style:TextStyle(fontSize: 20)),
      padding: EdgeInsets.fromLTRB(64,8, 64, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom:
          BorderSide(width: 1.0, color: Colors.black38),
        ),
      ),
    ),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {

    void toWandering() {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ConsciousPage(progress_time:current_time_selection,headsetService: headsetService!,);
        },
      ));
    }

    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Prompt'),
      home: Scaffold(
        // resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: Text("drawer")
        ),
        body: SafeArea(
            child: Container(
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Image.asset("assets/icons/pearl_full.png"),
                                onTap: ()=>{
                                  Navigator.pushNamed(context, "/demo1")
                                },
                              ),
                              Spacer(flex: 1,),
                              VolumeButton(),
                            ],
                          ),
                        ),
                        HeadsetConnector(onConnected: onConnected,),
                        Container(
                          height: 128,
                          child: ListWheelScrollView(itemExtent: 42, children: time_selection(),onSelectedItemChanged: onTimeChange,),
                        ),
                        Container(
                          height: 32,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          child: headsetService == null ? WhiteButton(title: 'เริ่ม',):OrangeButton(title: 'เริ่ม',onPress: toWandering,),
                        )
                      ],
                    ),
                  ),
                  // Container(height: 64,),
                  Spacer(flex: 1,),
                  ButtonNavigationBar(),
                ],
              ),
            )),
      ),
    );
  }
}
