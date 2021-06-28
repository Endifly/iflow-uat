import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/components/customWidgets/Typography.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/ActionPage/ColorSet.dart';
import '/views/ActionPage/RelaxPage/Flower.dart';
import '/views/Template/tLayout.dart';

class RelaxIntroduce extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RelaxIntroduceState();
  }

}

class _RelaxIntroduceState extends State<RelaxIntroduce> {

  CarouselController buttonCarouselController = CarouselController();

  Widget Card({child:Widget}) {
    return (
      Container(
        margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 12,
                spreadRadius: 3,
                offset: Offset(0,0),
              ),
            ]
        ),
        child: child,
      )
    );
  }

  Widget ColorRing(size,flowerSize,flowerState) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            gradient: SweepGradient(
              colors: relaxColorSets[0],
            ),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          height: size-12,
          width: size-12,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          child: Image.asset("assets/images/flower${flowerState}.png", height: flowerSize,),
        )
      ],
    );
  }

  Widget slide1() {
    return (
      Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/des_hero2.png"),
            CTypo(text: "สมาธิผ่อนคลาย",),
            CTypo(text: "ปล่อยให้จิตใจผ่อนคลาย เปิดกว้าง ไปเรื่อยๆอารมณ์เบิกบาน แล้วจะมีเสียงบอก",color: "secondary",textAlign: TextAlign.center,),
            SizedBox(height: 16,),
            Row(
              children: [
                SizedBox(width: 16,),
                ColorRing(140.0,90.0,3),
                SizedBox(width: 16,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      CTypo(text:"เมื่อมีการผ่อนคลาย",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"ดีแล้ว และสัญลักษณ์",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"ดอกไม้จะบานขึ้นเรื่อยๆ",color: "secondary",variant: "subtitle2",),
                    ]
                )
              ],
            ),
            SizedBox(height: 32,),
            Row(
              children: [
                SizedBox(width: 16,),
                ColorRing(140.0,100.0,5),
                SizedBox(width: 16,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      CTypo(text:"สีของวงกลมรอบนอก",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"จะเปลี่ยนตามแปลงไป",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"ตามสภาวะ ปัจจุบัน",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"โดยโทนสีเหลืองส้ม",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"บอกถึงสภาวะ",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"ผ่อนคลายมีสมาธิดี",color: "secondary",variant: "subtitle2",),
                    ]
                )
              ],
            ),
          ],
        )
      )
    );
  }

  Widget slide2() {
    return (
      Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 16,),
                ColorRing(160.0,90.0,3),
                SizedBox(width: 16,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      CTypo(text:"เมื่อมีการผ่อนคลาย",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"ดีแล้ว และสัญลักษณ์",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"ดอกไม้จะบานขึ้นเรื่อยๆ",color: "secondary",variant: "subtitle2",),
                    ]
                )
              ],
            ),
            SizedBox(height: 32,),
            Row(
              children: [
                SizedBox(width: 16,),
                ColorRing(160.0,140.0,5),
                SizedBox(width: 16,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      CTypo(text:"สีของวงกลมรอบนอก",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"จะเปลี่ยนตามแปลงไป",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"ตามสภาวะ ปัจจุบัน",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"โดยโทนสีเหลืองส้ม",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"บอกถึงสภาวะ",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"ผ่อนคลายมีสมาธิดี",color: "secondary",variant: "subtitle2",),
                    ]
                )
              ],
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                SizedBox(width: 16,),
                SizedBox(width: 160.0,),
                SizedBox(width: 16,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      CTypo(text:"โทนสีแดงบ่งบอกถึง",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"สภาวพฟุ้งคิด",color: "secondary",variant: "subtitle2",),
                    ]
                )
              ],
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                SizedBox(width: 16,),
                SizedBox(width: 160.0,),
                SizedBox(width: 16,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      CTypo(text:"โทนสีเขียว/ฟ้า",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"บ่งบอก ถึงสภาวะ",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"ที่จดจ่อ ไม่ผ่อนคลาย",color: "secondary",variant: "subtitle2",),
                    ]
                )
              ],
            ),
          ],
        )
      )
    );
  }

  Widget slide3() {
    return (
        Card(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8,),
                CTypo(text:"การประเมิณผลคะแนน",variant: "body1",color: "secondary",),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 600,
                        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        decoration: BoxDecoration(
                          color:kColors.gold[100]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(80),
                          
                        ),
                        child: Column(
                          children: [
                            Expanded(child: Image.asset("assets/images/sun4.png"),flex: 1,),
                            Expanded(child: Image.asset("assets/images/sun3.png"),flex: 1,),
                            Expanded(child: Image.asset("assets/images/sun2.png"),flex: 1,),
                            Expanded(child: Image.asset("assets/images/sun1.png"),flex: 1,),
                            // Image.asset("assets/images/sun1.png"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 600,
                        margin: EdgeInsets.fromLTRB(32, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset("assets/images/sun4.png"),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CTypo(text:"คะแนนมากกว่าเท่ากับ 56",color: "secondary",variant: "subtitle2",),
                                  CTypo(text:"เยี่ยมมาก เบิกบาก",color: "secondary",variant: "subtitle2",),
                                  CTypo(text:"แจ่มใส มีสมาธิดีมาก",color: "secondary",variant: "subtitle2",),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CTypo(text:"คะแนนมากกว่าเท่ากับ 51-55",color: "secondary",variant: "subtitle2",),
                                  CTypo(text:"เยี่ยมมาก ปานกลาง",color: "secondary",variant: "subtitle2",),
                                  CTypo(text:"มีสมาธิดี",color: "secondary",variant: "subtitle2",),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CTypo(text:"คะแนนมากกว่าเท่ากับ 45-50",color: "secondary",variant: "subtitle2",),
                                  CTypo(text:"อารมณ์ปกติ มีสมาธิ",color: "secondary",variant: "subtitle2",),
                                  CTypo(text:""),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CTypo(text:"คะแนนต่ำกว่า 45",color: "secondary",variant: "subtitle2",),
                                  CTypo(text:"อารมณ์จดจ่อมากเกินไป",color: "secondary",variant: "subtitle2",),
                                  CTypo(text:"ไม่ผ่อนคลาย",color: "secondary",variant: "subtitle2",),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   child: FractionallySizedBox(
                    //     widthFactor: 0.5,
                    //     child: Column(
                    //       children: [
                    //         Image.asset("assets/images/sun4.png"),
                    //       ],
                    //     ),
                    //   )
                    // ),
                  ],
                )
              ],
            )
        )
    );
  }

  List<Widget> introDuceSlide = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      introDuceSlide = [slide1(),slide3()];
    });
  }

  Widget Carousel() {
    if (buttonCarouselController == null) return Container();
    if (introDuceSlide == null) return Container();
    else return CarouselSlider(
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        height: 700.0,
        initialPage: 0,
        enableInfiniteScroll: false,
        viewportFraction: 1.0,
      ),
      items: introDuceSlide.map((widget) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: widget,
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    void onBack() {
      Navigator.pop(context);
    }

    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              // padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  SizedBox(height: 32,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: [
                        PrevIcon(onPress: onBack,),
                        // IconButton(icon: FaIcon(FontAwesomeIcons.handHoldingHeart)),
                        SizedBox(width: 125,),
                        CTypo(text: "ผ่อนคลาย",variant: "h6",),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Carousel(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}