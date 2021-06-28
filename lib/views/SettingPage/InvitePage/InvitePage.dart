import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/views/Template/NavLayout.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/Typography.dart';
import '/components/customWidgets/WhiteTextfield.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/Template/tLayout.dart';

class InvitePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InvitePageState();
  }

}

class _InvitePageState extends State<InvitePage> {
  @override
  Widget build(BuildContext context) {

    void onBack() {
      Navigator.pop(context);
    }

    // TODO: implement build
    return NavLayout(
      useSafeArea: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        // height: MediaQuery.of(context).size.height-96,
        child: Column(
          children: [
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrevIcon(onPress: onBack,),
                IconButton(icon: FaIcon(FontAwesomeIcons.handHoldingHeart), onPressed: () {  },),
              ],
            ),
            SizedBox(height: 16,),
            Divider(color: kColors.blue[500],),
            SizedBox(height: 32,),
            InviteHero(),
            SizedBox(height: 32,),
            CTypo(text:"เชิญชวนเพื่อน",variant: "body2",),
            CTypo(text:"แนะนำเพื่อให้รู้จักแอปพลิเคชั่น I Flow",color: "secondary",),
            CTypo(text:"ผ่านทาง Social network",color: "secondary"),
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: OrangeButton(title: "แชร์เลย",),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Divider(color: kColors.blue[500],),
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: WhiteTextfield(title: "Link code",),
                ),
              ],
            ),
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: OrangeButton(title: "คัดลอกลิงค์",),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InviteHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kColors.pink[100]!,
              offset: Offset(0,0),
              spreadRadius: 6,
              blurRadius: 12,
            )
          ],
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                kColors.coral[100]!,
                kColors.pink[300]!,
              ]
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset("assets/images/sun4.png"),
            width: MediaQuery.of(context).size.width*0.35,
          ),
          SizedBox(
            child: Image.asset("assets/images/cloud1.png"),
            width: MediaQuery.of(context).size.width*0.35,
          ),
        ],
      ),
    );
  }
}