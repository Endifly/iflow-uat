import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/components/customWidgets/Typography.dart';
import 'package:ios_d1/components/customWidgets/VolumeButton.dart';

class BatteryIndicator extends StatelessWidget {
  
  int batteryHealth = -1;
  
  BatteryIndicator({required this.batteryHealth});
  
  @override
  Widget build(BuildContext context) {

    Widget battery() {
      if (batteryHealth < 5) return Image.asset("assets/icons/battery_0.png");
      if (batteryHealth < 25) return Image.asset("assets/icons/battery_25.png");
      if (batteryHealth < 50) return Image.asset("assets/icons/battery_50.png");
      if (batteryHealth < 75) return Image.asset("assets/icons/battery_75.png");
      return Image.asset("assets/icons/battery_100.png");
    }

    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          battery(),
          SizedBox(width: 16,),
          Spacer(flex: 1,),
          VolumeButton(),
        ],
      ),
    );
  }
  
}