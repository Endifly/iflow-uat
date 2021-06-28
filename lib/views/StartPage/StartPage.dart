import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/components/ButtonNavigationBar.dart';
import '/components/customWidgets/HeadsetConnector.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/VolumeButton.dart';
import '/components/customWidgets/WhiteButton.dart';
import '/views/ActionPage/RelaxPage/RelaxPage.dart';

class StartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StatePageState();
  }
}

class _StatePageState extends State<StartPage> {
  // BluetoothDevice server;
  HeadsetService? headsetService;

  var current_time_selection = 1;

  var loadingValue = null;

  final List<int> timing = [1,3,5,10];

  void onTimeChange(int index) {
    setState(() {
      current_time_selection = timing[index];
    });
  }

  void onLoadSuccess() {
    setState(() {
      loadingValue = 100.0;
    });
  }

  void onConnected(HeadsetService _headsetService) {
    print("got headser service :${_headsetService.readSignalQuality()}");
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
    // TODO: implement build

    void toRelax() {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return RelaxPage(progress_time:current_time_selection,headsetService: headsetService!,);
        },
      ));
    }

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // drawer: Drawer(
        //   child: SelectBondedDevicePage(
        //     onCahtPage: (device1) {
        //       BluetoothDevice device = device1;
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) {
        //             return Scaffold();
        //           },
        //         ),
        //       );
        //     },
        //   ),
        // ),
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
                    // ElevatedButton(onPressed: ()=>{Scaffold.of(context).openDrawer()}, child: Text("open drawer")),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        children: [
                          InkWell(
                            child: Image.asset("assets/icons/iflow_full.png"),
                            onTap: ()=>Navigator.pushNamed(context, '/relax/introduce'),
                          ),
                          Spacer(flex: 1,),
                          VolumeButton(),
                        ],
                      ),
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeadsetConnector(onConnected: onConnected,),
                          Container(
                            height: 128,
                            child: ListWheelScrollView(
                                itemExtent: 64,
                                diameterRatio: 1.5,
                                children: time_selection(),
                                onSelectedItemChanged: onTimeChange,
                            ),
                          ),
                          Container(
                            height: 32,
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(249, 211, 78, 1),
                                      Color.fromRGBO(255, 242, 136, 1),
                                      Color.fromRGBO(238, 194, 58, 1)
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
                                ]),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: headsetService == null ? WhiteButton(title: 'เริ่ม',):OrangeButton(title: 'เริ่ม',onPress: toRelax,),
                            )
                          ),
                        ],
                      ),
                    ),
                    Spacer(flex: 1,),
                    ButtonNavigationBar(),
                  ],
                ),
              )
          ),
      );
  }
}
