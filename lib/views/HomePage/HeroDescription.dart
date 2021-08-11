import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/components/customWidgets/Typography.dart';

class HeroDescription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HeroDescriptionState();
  }
}

class HeroDescriptionState extends State<HeroDescription> {

  void onBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: ListView(
          children: [
            Center(
              child: CTypo(text: "คำอธิบาย"),
            ),
            InkWell(
              onTap: onBack,
              child: Hero(
                  tag: 'dash',
                  child: Image.asset("assets/images/sun4.png")
              ),
            ),
            CTypo(text: "ให้จิตใจเปิดกว้างไปเรื่อยๆ และ ให้ความสว่างสู่สภาพแวดล้อมรอบตัวไปเรื่อยๆ")
          ],
        ),
      ),
    );
  }

}