import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import '/components/customWidgets/Typography.dart' as Typo;
import '/components/customWidgets/WhiteButton.dart';
import '/components/icons/MinusIcon.dart';
import '/components/icons/NextIcon.dart';
import '/components/icons/PlusIcon.dart';
import '/components/icons/PrevIcon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WanderingGraphArguments {
  final List<int>? relaxIndexs;

  WanderingGraphArguments({this.relaxIndexs});
}

class ConsciousGraphPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ConsciousGraphPageState();
  }
}

class _ConsciousGraphPageState extends State<ConsciousGraphPage> {
  String? username = "";
  double? threshold = 60.0;
  List<int> selectedIndex = [0,10];
  int maxDisplay = 10;
  int loadCount = 3;

  // SwiperController controller;
  // List<SwiperController> controllers;
  

  List<Color> gradientColorsMindWandering = [
    const Color.fromRGBO(249, 192, 228, 1),
    const Color.fromRGBO(249, 192, 228, 0.6),
  ];

  List<Color> gradientColorsMediatation = [
    const Color.fromRGBO(255, 234, 174, 1),
    const Color.fromRGBO(255, 234, 174, 0.6),
  ];

  bool showAvg = false;

  void nextIndex() {
    setState(() {
      selectedIndex[0] = selectedIndex[0]+loadCount;
      selectedIndex[1] = selectedIndex[1]+loadCount;
    });
    print(selectedIndex);
  }


  void prevIndex() {
    setState(() {
      selectedIndex[0] = max(0,selectedIndex[0]-loadCount);
      selectedIndex[1] = max(maxDisplay,selectedIndex[1]-loadCount);
    });
    print(selectedIndex);
  }



  void onZoomIn() {
    setState(() {
      selectedIndex[1] = selectedIndex[0]+maxDisplay-1;
      maxDisplay = maxDisplay-1;
    });
    print(selectedIndex);
  }

  void onZoomOut() {
    setState(() {
      selectedIndex[1] = selectedIndex[0]+maxDisplay+1;
      maxDisplay = maxDisplay+1;
    });
    print(selectedIndex);
  }


  void _setup() async {
    // controller = new SwiperController();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = '${prefs.getString('${kPrefs.firstname}')} ${prefs.getString('${kPrefs.lastname}')}';
      threshold = prefs.getDouble('threshold');
    });
  }

  Widget mindGraph(colors,List<int> indexes) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        child: LineChart(
          mainData(threshold,colors,indexes,selectedIndex[0],selectedIndex[1],maxDisplay),
        ),
      ),
    );
  }

  Widget MindWanderingCard(List<int> indexes) {
    return Container(
        margin: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          // border: Border.all(color: Colors.grey,width: 1,style: BorderStyle.solid),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(1, 1),
                blurRadius: 12.0,
                spreadRadius: 3.0),
          ],
          color: Colors.white,
        ),
        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Typo.CTypo(text: "Mind Wondering Index"),
                    Typo.CTypo(text: "ดัชนีวัดสภาวะฟุ้งคิด"),
                  ],
                )
              ],
            ),
            SizedBox(height: 32,),
            mindGraph(gradientColorsMindWandering,indexes),
            SizedBox(height: 16,),
            Row(
              children: [
                PrevIcon(onPress: prevIndex,),
                Spacer(flex: 1,),
                NextIcon(onPress: nextIndex,),
              ],
            ),
            Typo.CTypo(text: "สรุปผลดัชนี ....",color: "secondary",),
            SizedBox(height: 32,),
            Row(
              children: [
                Container(width: 40,height: 2,color:Colors.grey),
                SizedBox(width: 16,),
                Typo.CTypo(text: "Threshold : ${threshold}",variant: "subtitle2",),
                // IconButton(onPressed: ()=>print("hello"), icon: FaIcon(FontAwesomeIcons.minus))
                Spacer(flex: 1,),
                MinusIcon(onPress: onZoomOut,),
                SizedBox(width: 16,),
                PlusIcon(onPress: onZoomIn,),
              ],
            )
          ],
        )
    );
  }

  Widget MediatationCard(List<int> indexs) {
    return Container(
        margin: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          // border: Border.all(color: Colors.grey,width: 1,style: BorderStyle.solid),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(1, 1),
                blurRadius: 12.0,
                spreadRadius: 3.0),
          ],
          color: Colors.white,
        ),
        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Typo.CTypo(text: "Mediatation Index"),
                    Typo.CTypo(text: "ดัชนีภาวะรู้สึกตัว"),
                  ],
                )
              ],
            ),
            SizedBox(height: 32,),
            mindGraph(gradientColorsMediatation,indexs),
            SizedBox(height: 16,),
            Row(
              children: [
                PrevIcon(onPress: prevIndex,),
                Spacer(flex: 1,),
                NextIcon(onPress: nextIndex,),
              ],
            ),
            Typo.CTypo(text: "สรุปผลดัชนี ....",color: "secondary",),
            SizedBox(height: 32,),
            Row(
              children: [
                Container(width: 40,height: 2,color:Colors.grey),
                SizedBox(width: 16,),
                Typo.CTypo(text: "Threshold : ${threshold}",variant: "subtitle2",),
                // IconButton(onPressed: ()=>print("hello"), icon: FaIcon(FontAwesomeIcons.minus))
                Spacer(flex: 1,),
                MinusIcon(onPress: onZoomOut,),
                SizedBox(width: 16,),
                PlusIcon(onPress: onZoomIn,),
              ],
            )
          ],
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final WanderingGraphArguments args = ModalRoute.of(context)?.settings.arguments as WanderingGraphArguments;
    print("args : ${args.relaxIndexs}");

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset("assets/images/person_2.png",height: 128,),
                  ),
                  SizedBox(width: 8,),
                  Column(
                    children: [
                      Typo.CTypo(text: "${username}",variant: "body1",color: "secondary",),
                      Typo.CTypo(text: '${tr('app.session')} ${tr('app.wandering')}',variant: "body1",color: "primary",),
                    ],
                  ),
                ],
              ),
            ),
            // GraphCard(),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: MindWanderingCard([]),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: MediatationCard(args.relaxIndexs!.sublist(selectedIndex[0],selectedIndex[1]+1)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 64,
              margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.3, 0, MediaQuery.of(context).size.width*0.3, 0),
              child: WhiteButton(title: tr('app.next'),),
            )
          ],
        ),
      ),
    );
  }

  LineChartData mainData(threslod,gradientColors,List<int> indexes,int startX,int endX,int maxDisplay) {

    List<FlSpot> makeData(List<int> values) {
      List<FlSpot> result = [];
      for (var i = 0 ; i < values.length; i++) {
        result.add(FlSpot(i.toDouble(), values[i].toDouble()));
      }
      return result;
    }

    return LineChartData(
      extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: threslod,
              color: Colors.grey.withOpacity(0.8),
              strokeWidth: 1,
              dashArray: [20, 2],
            ),
          ]
      ),
      gridData: FlGridData(
        verticalInterval: 3,
        horizontalInterval: 25,
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(color: Color(0xff68737d), fontSize: 12),
          getTitles: (value) {
            // switch (value.toInt()) {
            //   case 3:
            //     return '01:00';
            //   case 6:
            //     return '02:00';
            //   case 9:
            //     return '03:00';
            // }
            // return '';
            if ((startX+value)%10 == 0) {
              return "${startX+value}.00";
            }
            return "";
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            // fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return '10';
              case 50:
                return '50';
              case 100:
                return '100';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: maxDisplay.toDouble(),
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          // spots: [
          //   FlSpot(0, 20),
          //   FlSpot(2.6, 10),
          //   FlSpot(4.9, 60),
          //   FlSpot(6.8, 20),
          //   FlSpot(8, 80),
          //   FlSpot(9.5, 90),
          //   FlSpot(11, 0),
          // ],
          spots: makeData(indexes),
          isCurved: false,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors,
          ),
        ),
      ],
    );
  }
}