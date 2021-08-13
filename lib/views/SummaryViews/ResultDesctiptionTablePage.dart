import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/components/customWidgets/Typography.dart';
import 'package:ios_d1/components/icons/PrevIcon.dart';

class ResultDescriptionTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    void onBack() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left : 2.0,
                        child: PrevIcon(onPress: onBack,),
                      ),
                      CTypo(text: "รู้สึกตัว"),
                      Container(
                        height: 50,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24,),
                CTypo(
                    text: 'ให้คลายออกจากความฟุ้งคิด และการจดจ่อเปิดกว้างไปเรื่อยๆ โดยไม่ต้องให้ความสำคัญกับสิ่งที่ฟุ้ง แล้วเสียงที่เตือนจะหายไปเอง สัญลักษ์วงกลมโทนสีเหลืองก็จะกลับมา',
                    color: 'secondary',
                ),
                SizedBox(height: 24,),
                CTypo(
                  text: "ดัชนีประเมิณผล",variant:'body1',
                  textStyle: TextStyle(
                    decoration: TextDecoration.underline
                  ),
                ),
                SizedBox(height: 32,),
                Image.asset("assets/images/score_table.png")
              ],
            )
          ],
        ),
      ),
    );
  }
  
}