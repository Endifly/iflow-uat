import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/contexts/kTR.dart';
import '/components/customWidgets/Typography.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/SettingPage/Layout/SettingLayout.dart';

class VibrationSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VibrationSettingPageState();
  }

}

class _VibrationSettingPageState extends State<VibrationSettingPage> {

  bool vibrate = true;

  void onBack() {
    Navigator.pop(context);
  }

  void toggle({val:bool,type:String}) {
    switch(type) {
      case "vibrate" :
        setState(() {
          vibrate = val;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SettingLayout(
      child: Column(
        children: [
          SizedBox(height: 32,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrevIcon(onPress: onBack,),
              IconButton(icon: FaIcon(FontAwesomeIcons.volumeUp), onPressed: ()=>{},),
            ],
          ),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
          SizedBox(height: 16,),
          VibrateSettingButton(title: tr(kTR.appVibrationTitleSetting),desc: tr(kTR.appVibrationDescSetting),enable: vibrate,type: "vibrate",onPress: (value,type)=>toggle(val: value,type: type),),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
        ],
      ),
    );
  }
}

typedef void onPressCallback(value,type);

class VibrateSettingButton extends StatelessWidget {
  final String title;
  final String desc;
  final bool enable;
  final String type;
  final onPressCallback? onPress;

  VibrateSettingButton({required this.title,required this.desc,required this.enable,this.onPress,required this.type});

  FaIcon getIcon() {
    if (this.enable) return FaIcon(FontAwesomeIcons.volumeUp);
    return FaIcon(FontAwesomeIcons.volumeMute);
  }

  void onPressWrapper(bool value,String type) {
    if (onPress != null) onPress!(value,type);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CTypo(text:this.title,variant: "body1",color: "secondary",),
          CTypo(text:this.desc,color: "secondary",),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: getIcon(),onPressed: ()=>{},),
              Switch(
                value: enable,
                onChanged: (value)=>onPressWrapper(value,type),
                activeColor: kColors.gold[300],
              )
            ],
          )
        ],
      ),
    );
  }
}