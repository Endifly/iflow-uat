import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/customWidgets/Typography.dart';
import '/contexts/kColors.dart';

class HeadsetIntroduce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/iflow_full.png"),
          SizedBox(height: 256,),
          CTypo(text: "อุปกรณ์ Headset",variant: "body1",color: "secondary",),
          CTypo(text: "ที่ใช้งานร่วมกับ App I Flow",variant: "body1",color: "secondary",),
          CTypo(text: "ช่วยจัดเก็บประวัติสถิติของคุณ",variant: "subtitle1",color: "secondary",),
          CTypo(text: "พร้อมเชื่อมต่อสิทธิ และประโยชน์อื่น ๆ",variant: "subtitle1",color: "secondary",),
          CTypo(text: "ผ่าน Application",variant: "subtitle1",color: "secondary",),
          CTypo(text: "ดูรายละเอียด Headset",variant: "h6",textStyle: TextStyle(color: kColors.orange[400],decoration: TextDecoration.underline,),),
        ],
      ),
    );
  }

}