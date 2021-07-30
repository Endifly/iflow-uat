import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/components/customWidgets/Typography.dart';
import 'package:ios_d1/components/customWidgets/VolumeButton.dart';

class BatteryIndicator extends StatelessWidget {
  
  int batteryHealth = -1;
  
  BatteryIndicator({required this.batteryHealth});
  
  @override
  Widget build(BuildContext context) {

    FaIcon battery() {
      if (batteryHealth < 5) return FaIcon(FontAwesomeIcons.batteryEmpty);
      if (batteryHealth < 25) return FaIcon(FontAwesomeIcons.batteryQuarter);
      if (batteryHealth < 50) return FaIcon(FontAwesomeIcons.batteryHalf);
      if (batteryHealth < 75) return FaIcon(FontAwesomeIcons.batteryThreeQuarters);
      return FaIcon(FontAwesomeIcons.batteryFull);
    }

    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          battery(),
          SizedBox(width: 16,),
          CTypo(text: "${this.batteryHealth}",variant: "subtitle1",),
          Spacer(flex: 1,),
          VolumeButton(),
        ],
      ),
    );
  }
  
}