import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/Typography.dart';
import '/components/customWidgets/WhiteButton.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/SettingPage/Layout/SettingLayout.dart';
import '/views/Template/tLayout.dart';

class SendCommentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SendCommentPageState();
  }

}

class _SendCommentPageState extends State<SendCommentPage> {

  int point = 0;

  void onBack() {
    Navigator.pop(context);
  }

  // List<Widget> makeStar({number:int}) {
  //   List<Widget> stars = [];
  //   for (int i=0; i<number; i++) {
  //     stars.add(
  //       Container(
  //         child:
  //       )
  //     );
  //   }
  // }

  void setPoint({mpoint:int}) {
    print("point ${mpoint}");
    setState(() {
      point=mpoint;
    });
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
              IconButton(icon: FaIcon(FontAwesomeIcons.handHoldingHeart), onPressed: () {  },),
            ],
          ),
          SizedBox(height: 16,),
          Divider(color: kColors.blue[500],),
          SizedBox(height: 64,),
          Center(
            child: CTypo(text:"ส่งความคิดเห็น",variant: "h6",color: "secondary",),
          ),
          SizedBox(height: 32,),
          Center(
            child: CTypo(text:"กรุณาให้ข้อเสนอแนะ และให้คะแนนความพึงพอใจในการใช้งาน",variant: "body2",color: "secondary",textAlign: TextAlign.center,),
          ),
          SizedBox(height: 32,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: ()=>setPoint(mpoint: 1),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: point >= 1 ? Image.asset("assets/icons/star_activate.png") : Image.asset("assets/icons/star_inactivate.png"),
                ),
              ),
              InkWell(
                onTap: ()=>setPoint(mpoint: 2),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: point >= 2 ? Image.asset("assets/icons/star_activate.png") : Image.asset("assets/icons/star_inactivate.png"),
                ),
              ),
              InkWell(
                onTap: ()=>setPoint(mpoint: 3),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: point >= 3 ? Image.asset("assets/icons/star_activate.png") : Image.asset("assets/icons/star_inactivate.png"),
                ),
              ),
              InkWell(
                onTap: ()=>setPoint(mpoint: 4),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: point >= 4 ? Image.asset("assets/icons/star_activate.png") : Image.asset("assets/icons/star_inactivate.png"),
                ),
              ),
              InkWell(
                onTap: ()=>setPoint(mpoint: 5),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: point >= 5 ? Image.asset("assets/icons/star_activate.png") : Image.asset("assets/icons/star_inactivate.png"),
                ),
              ),
            ],
          ),
          SizedBox(height: 32,),
          Container(
            height: 128,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: kColors.orange[100]!,width: 3),
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          SizedBox(height: 32,),
          Center(
            child: OrangeButton(
              title: "ส่งข้อมูล",
            ),
          )
        ],
      ),
    );
  }

}