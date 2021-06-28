import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/components/customWidgets/Typography.dart';
import '/components/customWidgets/WhiteButton.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/SettingPage/Layout/SettingLayout.dart';
import '/views/Template/tLayout.dart';

class HelpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HelpPageState();
  }

}

class _HelpPageState extends State<HelpPage> {

  void onBack() {
    Navigator.pop(context);
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
              IconButton(icon: FaIcon(FontAwesomeIcons.handHoldingHeart),onPressed: ()=>{},),
            ],
          ),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
          SizedBox(height: 64,),
          Center(
            child: CTypo(text:"ขอความช่วยเหลือ",variant: "h6",color: "secondary",),
          ),
          SizedBox(height: 64,),
          WhiteButton(
            title: "Contact us",
          )
        ],
      ),
    );
  }

}