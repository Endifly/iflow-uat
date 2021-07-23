import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/Typography.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/SettingPage/Layout/SettingLayout.dart';

class PrivacyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PrivacyPageState();
  }

}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {

    void onBack() {
      Navigator.pop(context);
    }

    // TODO: implement build
    return SettingLayout(
      child: Column(
        children: [
          SizedBox(height: 32,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrevIcon(onPress: onBack,),
              IconButton(icon: FaIcon(FontAwesomeIcons.userShield), onPressed: () {  },),
            ],
          ),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
          SizedBox(height: 32,),
          CTypo(text:tr('setting.privacy.title'),variant: "body2",),
          SizedBox(height: 8,),
          CTypo(text:tr('setting.privacy.desc'),color: "secondary",),
          SizedBox(height: 32,),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width*1.0,
              child: OrangeButton(title: tr('setting.privacy.openPolicyButton'),),
            ),
          ),
          SizedBox(height: 64,),
          Divider(color: kColors.blue[500],),
        ],
      ),
    );
  }

}