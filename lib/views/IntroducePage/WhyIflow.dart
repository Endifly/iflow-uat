import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/customWidgets/WhiteButton.dart';

class WhyIflow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height*0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ทำไม i Flow",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20),),
          Image.asset("assets/images/intro1.png"),
          SizedBox(height: 64,),
          Text("เทคโนโลยีวัดคลื่นไฟฟ้าสมอง",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20),),
          Text("(Electroencephalography)",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 20),),
          Text("สมมารถวัดความฟุ้งคิด เพ่งจ้อง",style: TextStyle(fontSize: 16),),
          Text("และผ่อนคลายของผู้ใช้งาน",style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }
}