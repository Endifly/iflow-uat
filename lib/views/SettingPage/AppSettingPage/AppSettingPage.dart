import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/SettingPage/Layout/SettingLayout.dart';
import '/views/SettingPage/SettingPage.dart';

class AppSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppSettingPageState();
  }

}

class _AppSettingPageState extends State<AppSettingPage> {

  void onBack() {
    Navigator.pop(context);
  }

  void to(path) {
    Navigator.pushNamed(context, '/setting/app${path}');
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
              IconButton(icon: FaIcon(FontAwesomeIcons.cog),onPressed: ()=>{},),
            ],
          ),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
          SizedBox(height: 32,),
          SettingWhiteButton(title: "ตั้งค่าเสียง",icon: FaIcon(FontAwesomeIcons.volumeUp),onPress: ()=>to('/voice')),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
          SizedBox(height: 16,),
          SettingWhiteButton(title: "ตั้งค่าการสั่น",icon: FaIcon(FontAwesomeIcons.volumeUp),onPress: ()=>to('/vibrate')),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
          SizedBox(height: 16,),
          SettingWhiteButton(title: "กำหนดค่า Threshold",icon: FaIcon(FontAwesomeIcons.chartLine),onPress: ()=>to('/threshold'),),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
        ],
      ),
    );
  }

}