import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/customWidgets/WhiteButton.dart';

class Introduce2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/intro2.png"),
          SizedBox(height: 64,),
          Text("ประมวลข้อมูลเชิงสถิติที่",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20),),
          Text("ตรวจวัดได้",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20),),
          Text("สามารถประมวลผล เพื่อช่วยพัฒนา",style: TextStyle(fontSize: 16),),
          Text("การฝึกสภาวะเบิกบากของคุณ",style: TextStyle(fontSize: 16),),
          Text("ส่งเสริมเพิ่มอัจฉริยะภาพทางปัญญา",style: TextStyle(fontSize: 16),),
          Text("และความฉลาดทางอารมณ์",style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }
}