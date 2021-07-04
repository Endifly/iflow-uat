import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:ios_d1/components/customWidgets/HeadsetConnector.dart';
import 'package:ios_d1/components/customWidgets/OrangeButton.dart';
import 'package:ios_d1/components/customWidgets/Typography.dart';
import 'package:ios_d1/contexts/kColors.dart';

class HeadsetRSSI extends StatefulWidget {
  final HeadsetService headsetService;
  final int poorQuality;

  HeadsetRSSI({required this.headsetService,required this.poorQuality});

  @override
  State<StatefulWidget> createState() {
    return _HeadsetRSSIState();
  }
}

class _HeadsetRSSIState extends State<HeadsetRSSI> {

  int signalStr = 0; // 0,1,2
  int signalQuality = 0;
  FlutterBlue flutterBlue = FlutterBlue.instance;

  void updateSignalQuality() async {
    var sq = await widget.headsetService.readSignalQuality();
    print(sq);
  }

  @override
  void initState() {
    // TODO: implement initState
    updateSignalQuality();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          CTypo(text: "Signal Quality",color: 'secondary',),
          SizedBox(height: 16,),
          DotIndicator(count: 3,signalStrength: widget.poorQuality,),
          // OrangeButton(title: "reload",onPress: ()=>updateSignalQuality(),)
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget{

  final int count;
  final int signalStrength;

  DotIndicator({required this.count,required this.signalStrength});

  Color getColor() {
    if (signalStrength == 0) return kColors.green[500]!;
    if (signalStrength > 0 && signalStrength <= 80) return kColors.orange[500]!;
    return kColors.coral[500]!;
  }

  List<bool> dotCover() {
    if (signalStrength == 0) return [true,true,true];
    if (signalStrength > 0 && signalStrength <= 80) return [false,true,true];
    return [false,false,true];
  }

  Widget Dot(int _index) {
    return Container(
      width: 12,
      height: 12,
      margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: dotCover()[_index] ? getColor().withOpacity(0.8) : Colors.grey.withOpacity(0.8),
          width: 2,
        ),
        color: dotCover()[_index] ? getColor() : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  List<Widget> Dots() {
    List<Widget> dots = [];
    for (var i=0; i<count ; i++) {
      dots.add(Dot(i));
    }
    return dots.toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Dots(),
      ),
    );
  }

}