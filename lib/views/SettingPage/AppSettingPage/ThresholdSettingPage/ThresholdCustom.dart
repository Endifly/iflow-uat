import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/views/Template/NavLayout.dart';
import '/components/customWidgets/Typography.dart';
import '/components/icons/MinusIcon.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/SettingPage/Layout/SettingLayout.dart';
import '/views/Template/tLayout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThresholdCustomPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThresholdCustomPageState();
  }

}

class _ThresholdCustomPageState extends State<ThresholdCustomPage> {
  double? _threshold = 20;

  List<Color> gradientColors = [
    const Color.fromRGBO(249, 192, 228, 1),
    const Color.fromRGBO(249, 192, 228, 0.6),
  ];

  void setThreshold({required double threshold}) async {
    print("setting ...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('threshold', threshold);
  }

  void _setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? threshold = prefs.getDouble('threshold');
    setState(() {
      if (threshold == null) {
        _threshold = 20;
      }
      else {
        _threshold = threshold;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _setup();
    super.initState();
  }



  Widget mindGraph() {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        child: LineChart(
          mainData(threslod: _threshold),
        ),
      ),
    );
  }

  LineChartData mainData({threslod:double}) {
    return LineChartData(
      extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: threslod,
              color: kColors.yellow[400]!.withOpacity(0.8),
              strokeWidth: 3,
              // dashArray: [20, 2],
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
            switch (value.toInt()) {
              case 3:
                return '01:00';
              case 6:
                return '02:00';
              case 9:
                return '03:00';
            }
            return '';
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
      maxX: 11,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 20),
            FlSpot(2.6, 10),
            FlSpot(4.9, 60),
            FlSpot(6.8, 20),
            FlSpot(8, 80),
            FlSpot(9.5, 90),
            FlSpot(11, 0),
          ],
          isCurved: false,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color).toList(),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    void onBack() {
      Navigator.pop(context);
    }

    Widget header() {
      return Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrevIcon(onPress: onBack,),
            IconButton(icon: FaIcon(FontAwesomeIcons.cog),onPressed: ()=>{},),
          ],
        ),
      );
    }

    Widget constrain() {
      return Container(
        child: Column(
          children: [
            CTypo(text:">65 : ดีเยี่ยม",color:"secondary"),
            CTypo(text:"55-65 : ดีมาก",color:"secondary"),
            CTypo(text:"46-54 : ดี",color:"secondary"),
            CTypo(text:">65 : เบิกบานกว่านี้",color:"secondary"),
          ],
        ),
      );
    }

    // TODO: implement build
    return NavLayout(
      // customEdge: EdgeInsets.fromLTRB(8, 0, 8, 0),
      useSafeArea: false,
      child: Container(
        // padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
        // height: MediaQuery.of(context).size.height-96,
        padding: EdgeInsets.fromLTRB(8, 0, 8, 12),
        child: Column(
          children: [
            SizedBox(height: 32,),
            header(),
            SizedBox(height: 16,),
            Divider(color: kColors.blue[500],),
            SizedBox(height: 16,),
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0,9),
                      blurRadius: 12,
                      spreadRadius: 1,
                    )
                  ]
              ),
              child: Column(
                children: [
                  SizedBox(height: 32,),
                  CTypo(text:"เกณท์การประเมินค่าเฉลี่ยของ App:"),
                  SizedBox(height: 16,),
                  Image.asset("assets/images/sun4.png"),
                  SizedBox(height: 16,),
                  Padding(
                    padding:EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: ThresholdHero(),
                  ),
                  SizedBox(height: 24,),
                  constrain(),


                  SizedBox(height: 16,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Divider(color: kColors.blue[500],),
                  ),
                  SizedBox(height: 16,),


                  CTypo(text: "ตั้งค่า Threshold ของคุณเอง",variant: "body2",),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: CTypo(text: "แอปจะแจ้งเตือน (ทางเสียงหรือระบบสั่น)เมื่อท่านเบิกบานในระดับที่ตั้งค่าไว้ตามเกณท์ค่า Threshold",variant: "subtitle1",color: "secondary",),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(icon: FaIcon(FontAwesomeIcons.bell),onPressed: ()=>{},),
                      CTypo(text: "เกณฑ์ค่า Threshold",),
                      CTypo(text: "ค่า 60   =   ดี",),
                      CTypo(text: "ค่า 70   =   ดีมาก",),
                      CTypo(text: "ค่า 80   =   ดีเยี่ยม",),
                    ],
                  ),
                  Slider(
                    value: _threshold!,
                    min: 0,
                    max: 100,
                    divisions: 5,
                    activeColor: kColors.gold[500],
                    inactiveColor: kColors.gold[200],
                    label: _threshold!.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _threshold = value;
                        setThreshold(threshold: value);
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CTypo(text: "ค่า Threshold ปัจจุบัน",variant: "body2",color: "secondary",),
                      SizedBox(width: 16,),
                      Container(
                        child: Container(
                          // height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(255, 210, 105, 0.5),
                              ),
                              BoxShadow(
                                color: Colors.white,
                                spreadRadius: -1.0,
                                blurRadius: 1.0,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Color.fromRGBO(255, 231, 178, 0.5),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Color.fromRGBO(255, 210, 105, 0.5),
                              //   ),
                              //   BoxShadow(
                              //     color: Colors.white,
                              //     spreadRadius: -1.0,
                              //     blurRadius: 1.0,
                              //     offset: Offset(2, 2),
                              //   ),
                              // ],
                            ),
                            child: CTypo(text: "${_threshold}",),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32,),
                  mindGraph(),
                  SizedBox(height: 64,),
                ],
              ),
            ),
            SizedBox(height: 64,),
          ],
        ),
      ),
    );
  }
}

class ThresholdHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kColors.orange[100]!,
              offset: Offset(0,0),
              spreadRadius: 6,
              blurRadius: 12,
            )
          ],
          borderRadius: BorderRadius.circular(64),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                kColors.orange[300]!,
                kColors.orange[400]!,
              ]
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.22,
            child: Column(
              children: [
                Image.asset("assets/images/sun4.png"),
                CTypo(text:"ดีเยี่ยม",variant: "subtitle2",textStyle: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/sun2.png"),
                CTypo(text:"ดี",variant: "subtitle2",textStyle: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/sun1.png"),
                CTypo(text:"เบิกบานกว่านี้",variant: "subtitle2",textStyle: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}