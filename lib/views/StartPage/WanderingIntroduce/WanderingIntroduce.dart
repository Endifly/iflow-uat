import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/components/customWidgets/Typography.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/ActionPage/ColorSet.dart';
import '/views/ActionPage/ConsciousPage/Circle.dart';
import '/views/ActionPage/RelaxPage/Flower.dart';
import '/views/Template/tLayout.dart';

class WanderingIntroduce extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WanderingIntroduceState();
  }

}

class _WanderingIntroduceState extends State<WanderingIntroduce> {

  CarouselController buttonCarouselController = CarouselController();

  num degreesToRads(num deg) {
    return (deg * pi) / 180.0;
  }

  EdgeInsets positionCalculate({required double distance,required double angle}){
    var _angle = degreesToRads(angle);
    // print("distance : ${distance},angle : ${_angle}, trigo : ${cos(_angle)}");
    double xDistance = distance*cos(_angle);
    double yDistance = distance*sin(_angle);
    // print("xDistance : ${xDistance},yDistance : ${yDistance}");
    double ml = 0.0;
    double mt = 0.0;
    double mr = 0.0;
    double mb = 0.0;
    if (xDistance >= 0) {
      ml = xDistance;
    } else {
      mr = xDistance.abs();
    };
    if (yDistance >= 0) {
      mb = yDistance;
    } else {
      mt = yDistance.abs();
    };
    // print("margin ${ml} ${mt} ${mr} ${mb}");
    return EdgeInsets.fromLTRB(ml, mt, mr, mb);
  }

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
                Image.asset("assets/images/des_hero1.png"),
                CTypo(text: "รู้สึกตัว",),
                CTypo(text: "ปล่อยให้จิตใจผ่อนคลาย เปิดกว้าง ไปเรื่อยๆอารมณ์เบิกบาน อยู่ในสภาวะของการรู้สึกตัวและปล่อยวาง",color: "secondary",textAlign: TextAlign.center,),
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
                    Container(
                      height: 160,
                      width: 160,
                      child: Stack(
                        children: [
                          Circle(
                            opacity: 1.0,
                            color1: Colors.deepOrange.withOpacity(0.3),
                            color2: Color.fromRGBO(242, 104, 231, 1).withOpacity(1),
                            colorBase: Colors.yellow.withOpacity(0.5),
                          ),
                        ],
                      )
                    ),
                    SizedBox(width: 16,),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          CTypo(text:"สัญลักษณ์จะเป็นวงกลม",color: "secondary",variant: "subtitle2",),
                          CTypo(text:"โทนสีเหลืองชัดเจน",color: "secondary",variant: "subtitle2",),
                        ]
                    )
                  ],
                ),
                SizedBox(height: 32,),
                Row(
                  children: [
                    SizedBox(width: 16,),
                    Container(
                      height: 160,
                      width: 160,
                      child: ClipRRect(
                        child: Stack(
                          children: [
                            Circle(
                              edgeInsets: positionCalculate(angle: 225,distance: 20),
                              opacity: 0.3,
                              color1: Colors.deepOrangeAccent.withOpacity(0.8),
                              color2: Colors.yellow,
                              colorBase: Colors.purple.withOpacity(0.8),
                            ),
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),
                            Circle(
                              edgeInsets: positionCalculate(angle: 45,distance: 20),
                              opacity: 0.9,
                              color1: Colors.deepOrangeAccent.withOpacity(0.8),
                              color2: Colors.yellow,
                              colorBase: Colors.purple.withOpacity(0.8),
                            ),
                          ],
                        ),
                      )
                    ),
                    SizedBox(width: 16,),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          CTypo(text:"เมื่อไรที่ฟุ้งคิดเรื่องอื่นๆ",color: "secondary",variant: "subtitle2",),
                          CTypo(text:"จะมีเสียงเตือนวงกลมจะ",color: "secondary",variant: "subtitle2",),
                          CTypo(text:"เปลี่ยนเป็นสีโทนแดง",color: "secondary",variant: "subtitle2",),
                          CTypo(text:"และกระจายตัวออก",color: "secondary",variant: "subtitle2",),
                        ]
                    )
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    SizedBox(width: 16,),
                    Container(
                      height: 160,
                      width: 160,
                      child: ClipRRect(
                        child: Stack(
                          children: [
                            Circle(
                              edgeInsets: positionCalculate(angle: 90,distance: 20),
                              opacity: 0.3,
                              color1: Colors.blue,
                              color2: Colors.green.withOpacity(0.6),
                              colorBase: Colors.yellow,
                            ),
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),
                            Circle(
                              edgeInsets: positionCalculate(angle: 270,distance: 20),
                              opacity: 0.9,
                              color1: Colors.blue,
                              color2: Colors.green.withOpacity(0.6),
                              colorBase: Colors.yellow,
                            ),
                          ],
                        ),
                      )
                    ),
                    SizedBox(width: 16,),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          CTypo(text:"เมื่อสภาวะจดจ่อไม่ผ่อน",color: "secondary",variant: "subtitle2",),
                          CTypo(text:"คลาย วงกลมจะเปลี่ยน",color: "secondary",variant: "subtitle2",),
                          CTypo(text:"เป็นสีโทนสีเขียว/ฟ้า",color: "secondary",variant: "subtitle2",),
                          CTypo(text:"และกระจายตัวออก",color: "secondary",variant: "subtitle2",),
                        ]
                    )
                  ],
                ),
                SizedBox(height: 16,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      CTypo(text:"ให้คลายความฟุ้งคิด และการจดจ่อ",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"เปิดกว้างไปเรื่อยๆ ไม่ต้องให้ความสำคัญกับ",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"สิ่งที่ฟุ้ง แล้วเสียงเตือนจะหายไปเอง",color: "secondary",variant: "subtitle2",),
                      CTypo(text:"สัญลักษณ์วงกลมโทนเหลืองก็จะกลับมา",color: "secondary",variant: "subtitle2",),
                    ]
                ),
                // Row(
                //   children: [
                //     SizedBox(width: 16,),
                //     Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children:[
                //           CTypo(text:"ให้คลายความฟุ้งคิด และการจดจ่อ",color: "secondary",variant: "subtitle2",textAlign: TextAlign.center,),
                //           CTypo(text:"เปิดกว้างไปเรื่อยๆ ไม่ต้องให้ความสำคัญกับ",color: "secondary",variant: "subtitle2",),
                //           CTypo(text:"สิ่งที่ฟุ้ง แล้วเสียงเตือนจะหายไปเอง",color: "secondary",variant: "subtitle2",),
                //           CTypo(text:"สัญลักษณ์วงกลมโทนเหลืองก็จะกลับมา",color: "secondary",variant: "subtitle2",),
                //         ]
                //     )
                //   ],
                // ),
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
                CTypo(text:"การประเมิณผลคะแนน",variant: "h6",),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 600,
                        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        decoration: BoxDecoration(
                          color:kColors.orange[100]!.withOpacity(0.5),
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
                        child: Column(
                          children: [
                            // Image.asset("assets/images/sun4.png"),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CTypo(text:"คะแนนมากกว่าเท่ากับ 56"),
                                  CTypo(text:"เยี่ยมมาก เบิกบาก"),
                                  CTypo(text:"แจ่มใส มีสมาธิดีมาก"),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CTypo(text:"คะแนนมากกว่าเท่ากับ 51-55"),
                                  CTypo(text:"เยี่ยมมาก ปานกลาง"),
                                  CTypo(text:"มีสมาธิดี"),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CTypo(text:"คะแนนมากกว่าเท่ากับ 45-50"),
                                  CTypo(text:"อารมณ์ปกติ มีสมาธิ"),
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
                                  CTypo(text:"คะแนนต่ำกว่า 45"),
                                  CTypo(text:"อารมณ์จดจ่อมากเกินไป"),
                                  CTypo(text:"ไม่ผ่อนคลาย"),
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
      introDuceSlide = [slide1(),slide2(),slide3()];
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
                        SizedBox(width: 130,),
                        CTypo(text: "รู้สึกตัว",variant: "h6",),
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