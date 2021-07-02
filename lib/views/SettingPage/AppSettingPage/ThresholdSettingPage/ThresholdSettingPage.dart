import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/Provider/ProfileProvider.dart';
import 'package:provider/provider.dart';
import '/components/customWidgets/Typography.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/SettingPage/Layout/SettingLayout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThresholdSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThresholdSettingPageState();
  }

}

class _ThresholdSettingPageState extends State<ThresholdSettingPage> {

  double? _threshold = 0.0;

  void _setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _threshold = prefs.getDouble('threshold');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _setup();
    super.initState();
  }

  Widget _button(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      // width: MediaQuery.of(context).size.width*0.7,
      child:Row(
        children: [
          SizedBox(width: 16,),
          CTypo(text: "ตั้งค่า Threshold ของคุณเอง",variant: "subtitle1",),
          // SizedBox(width: 16,),
          SizedBox(
            height: 56,
            child: FittedBox(
              child: IconButton(icon: FaIcon(FontAwesomeIcons.caretRight),onPressed: ()=>{},),
            ),
          ),
          // SizedBox(width: 16,),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end : Alignment.centerRight,
          colors: [
            kColors.gold[100]!,
            kColors.gold[300]!,
          ],
          // stops: [0.4,0.8,1.0]
        ),
        boxShadow:[
          BoxShadow(
            color: kColors.black[500]!.withOpacity(0.1),
            offset: Offset(3,3),
            blurRadius: 12,
            spreadRadius: 4,
          )
        ],
        borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    void onBack() {
      Navigator.pop(context);
    }

    void to(path) {
      Navigator.pushNamed(context, '/setting/app/threshold${path}');
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
              IconButton(icon: FaIcon(FontAwesomeIcons.chartLine), onPressed: ()=>{},),
            ],
          ),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
          SizedBox(height: 16,),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CTypo(text:"กำหนดค่า Threshold",variant: "body1",color: "secondary",),
                CTypo(text:"ตั้งค่าแจ้งเตือน เมื่อค่าสมาธิผ่อนคลายถึงเกณท์ที่กำหนด",color: "secondary",),
                SizedBox(height: 24,),
                CTypo(text:"ค่า Threshold ปัจจุบัน",variant: "body1",color: "secondary",),
                CTypo(text:": ${profileProvider.threshold}",color: "secondary",),
              ],
            ),
          ),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
          SizedBox(height: 16,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CTypo(text: "ค่ามาตรฐาน",color: "secondary"),
                Switch(
                    value: true,
                    onChanged: (value)=>print(value),
                    activeColor: kColors.gold[300],
                ),
              ],
            ),
          ),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
          SizedBox(height: 16,),
          Container(
            child: InkWell(
              onTap: ()=>to('/custom'),
              child: _button(context),
            ),
          ),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
        ],
      ),
    );
  }

}