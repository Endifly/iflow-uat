import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:ios_d1/views/Template/NavLayout.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  static const String assetName = 'assets/icons/SVG/wandering.svg';
  final Widget wanderingIcon = SvgPicture.asset(
      'assets/icons/SVG/wandering.svg',
      semanticsLabel: 'Acme Logo'
  );

  void svgCheck() {
    final SvgParser parser = SvgParser();
    try {
      parser.parse(assetName, warningsAsErrors: true);
      print('SVG is supported');
    } catch (e) {
      print('SVG contains unsupported features');
    }
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
      child: Text('${time} ${tr('app.minute')}', style:TextStyle(fontSize: 20)),
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

    Widget Wandering() {
      Widget wander = Image.asset("assets/icons/wandering_full.png");
      Widget wanderContainer = Container(
        margin:EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: wander,
      );
      return wanderContainer;
    }

    // TODO: implement build
    return NavLayout(
      useSafeArea: false,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 64, 16, 0),
                  child: Row(
                    children: [
                      Wandering(),
                      Spacer(flex: 1,),
                      VolumeButton(),
                    ],
                  ),
                ),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: headsetService == null ? WhiteButton(title: tr('app.start'),onPress: svgCheck,):OrangeButton(title: tr('app.start'),onPress: toWandering,),
                  ),
                )
              ],
            ),
          ),
          // Container(height: 64,),
        ],
      ),
    );
  }
}
