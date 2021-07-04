import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/views/SettingPage/components/ClearPrefsButton.dart';
import 'package:ios_d1/views/SettingPage/components/LogoutButton.dart';
import 'package:ios_d1/views/Template/NavLayout.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/Typography.dart';
import '/contexts/kColors.dart';
import '/components/ButtonNavigationBar.dart';
import '/views/SettingPage/components/InviteCard.dart';
import '/views/Template/tLayout.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {

  Widget personalCard() {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width*0.3,
      decoration: BoxDecoration(
        color: kColors.gold[400]!.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        boxShadow:[
          BoxShadow(
            color: kColors.gold[400]!.withOpacity(0.3),
            offset: Offset(0,0),
            blurRadius: 8,
            spreadRadius: 4,
          )
        ]
      ),
      child: Column(
        children: [
          SizedBox(height: 16,),
          Row(
            children: [
              SizedBox(
                height: 72,
                // width: 64,
                child: FittedBox(
                  child: IconButton(icon: FaIcon(FontAwesomeIcons.user), onPressed: ()=>{},),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          Spacer(flex: 1,),
          CTypo(text: "ข้อมูลส่วนตัว",color: "secondary",),
          SizedBox(height: 16,),
        ],
      ),
    );
  }

  // Widget inviteCard() {
  //   return AnimatedContainer(
  //     height: 160,
  //     duration: Duration(microseconds: 500),
  //     width: MediaQuery.of(context).size.width*0.3,
  //     decoration: BoxDecoration(
  //       color: kColors.pink[400].withOpacity(0.8),
  //       borderRadius: BorderRadius.circular(24),
  //         boxShadow:[
  //           BoxShadow(
  //             color: kColors.pink[400].withOpacity(0.3),
  //             offset: Offset(0,0),
  //             blurRadius: 8,
  //             spreadRadius: 4,
  //           )
  //         ]
  //     ),
  //     child: Column(
  //       children: [
  //         SizedBox(height: 16,),
  //         Row(
  //           children: [
  //             SizedBox(
  //               height: 72,
  //               // width: 64,
  //               child: FittedBox(
  //                 child: IconButton(icon: FaIcon(FontAwesomeIcons.handHoldingHeart)),
  //               ),
  //             )
  //           ],
  //           mainAxisAlignment: MainAxisAlignment.start,
  //         ),
  //         Spacer(flex: 1,),
  //         CTypo(text: "เชิญชวนเพื่อน",color: "secondary",),
  //         SizedBox(height: 16,),
  //       ],
  //     ),
  //   );
  // }



  @override
  Widget build(BuildContext context) {

    void to({path:String}) {
      Navigator.pushNamed(context, '/setting${path}');
    }
    // TODO: implement build
    return NavLayout(
      useSafeArea: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        height: MediaQuery.of(context).size.height-96,
        child:
        ListView(
          children: [
            SizedBox(height: 64,),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Image.asset("assets/icons/setting1.png"), onPressed: ()=>{},),
                SizedBox(width: 64,),
                CTypo(text: "ตั้งค่าระบบ",variant: "h6",),
              ],
            ),
            SizedBox(height: 16,),
            Divider(color: kColors.blue[500],),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: ()=>to(path: "/personal"),
                  child: personalCard(),
                ),
                // InkWell(
                //   onTap: ()=>to(path: "/invite"),
                //   child: InviteCard(),
                // ),
                InviteCard(onPress: ()=>to(path: "/invite"),),
              ],
            ),
            SizedBox(height: 32,),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                children: [
                  SettingWhiteButton(icon: FaIcon(FontAwesomeIcons.userShield),title: "ความเป็นส่วนตัว",onPress: ()=>to(path: "/privacy"),),
                  SizedBox(height: 24,),
                  SettingWhiteButton(icon: FaIcon(FontAwesomeIcons.cog),title: "ตั้งค่าการใช้งาน",onPress: ()=>to(path: "/app"),),
                  SizedBox(height: 24,),
                  SettingWhiteButton(icon: FaIcon(FontAwesomeIcons.infoCircle),title: "ขอความช่วยเหลือ",onPress: ()=>to(path: "/help"),),
                  SizedBox(height: 24,),
                  SettingWhiteButton(icon: FaIcon(FontAwesomeIcons.envelope),title: "ส่งความเห็น",onPress: ()=>to(path: "/comment"),),
                  SizedBox(height: 24,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: ClearPrefsButton(),
                  ),
                  SizedBox(height: 24,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: LogoutButton(),
                  ),
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

typedef void onPressCallback();

class SettingOrangeButton extends StatelessWidget {
  final String title;
  final FaIcon icon;
  final onPressCallback onPress;

  SettingOrangeButton({required this.title,required this.icon,required this.onPress});

  Widget _button(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      width: MediaQuery.of(context).size.width*0.7,
      child:Row(
        children: [
          SizedBox(width: 16,),
          SizedBox(
            height: 64,
            child: FittedBox(
              child: IconButton(icon: icon, onPressed: ()=>{},),
            ),
          ),
          SizedBox(width: 16,),
          CTypo(text: title,),
          SizedBox(width: 16,),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end : Alignment.centerRight,
          colors: [
            kColors.gold[300]!,
            kColors.gold[100]!,
          ],
          // stops: [0.4,0.8,1.0]
        ),
          boxShadow:[
            BoxShadow(
              color: kColors.black[500]!.withOpacity(0.1),
              offset: Offset(3,3),
              blurRadius: 12,
              spreadRadius: 4,
            )
          ],
        borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(40),
      focusColor: Colors.transparent,
      splashColor: kColors.gold[300],
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: _button(context),
    );
  }
}

class SettingWhiteButton extends StatelessWidget {
  final String title;
  final FaIcon icon;
  final onPressCallback onPress;

  SettingWhiteButton({required this.title,required this.icon,required this.onPress});

  Widget _button(context) {
    return Container(
      // height: 48,
      // width: MediaQuery.of(context).size.width*0.7,
      padding: EdgeInsets.fromLTRB(2,0,2,0),
      child:Row(
        children: [
          SizedBox(width: 16,),
          SizedBox(
            height: 64,
            child: FittedBox(
              child: IconButton(icon: icon, onPressed: ()=>{},),
            ),
          ),
          SizedBox(width: 16,),
          CTypo(text: title,),
          SizedBox(width: 16,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(40),
      focusColor: Colors.transparent,
      splashColor: kColors.gold[300],
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: _button(context),
    );
  }
}