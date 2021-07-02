import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:ios_d1/views/Template/NavLayout.dart';
import '/components/ProfileImage.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/Textfield.dart';
import '/components/customWidgets/Typography.dart';
import '/components/icons/PrevIcon.dart';
import '/contexts/kColors.dart';
import '/views/Template/tLayout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfomationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonalInfomationPageState();
  }

}

class _PersonalInfomationPageState extends State<PersonalInfomationPage> {

  String? username = "";
  String? avatarURL = "";

  void _setupSharePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(kPrefs.username);
      avatarURL = prefs.getString(kPrefs.avatarURL);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _setupSharePreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    void onBack() {
      Navigator.pop(context);
    }

    return NavLayout(
      useSafeArea: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(36, 36, 36, 0),
        // height: MediaQuery.of(context).size.height-96,
        child:
        Column(
          children: [
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrevIcon(onPress: onBack,),
                IconButton(icon: FaIcon(FontAwesomeIcons.user), onPressed: () {  },),
              ],
            ),
            SizedBox(height: 16,),
            Divider(color: kColors.blue[500],),
            ProfileImage(imagePath: avatarURL!,),
            CTypo(text:"ข้อมูลส่วนตัว",variant: "body2",),
            SizedBox(height: 32,),
            OrangeTextfield(title: "${username}",),
            SizedBox(height: 32,),
            OrangeTextfield(title:"Password"),
            SizedBox(height: 8,),
            CTypo(text:"อย่างน้อย 8 ตัวอักษร",textStyle: TextStyle(color: kColors.gold[500]),),
            SizedBox(height: 32,),
            OrangeTextfield(title:"0818625000"),
            SizedBox(height: 32,),
            OrangeTextfield(title:"myemail@gmail.com"),
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: OrangeButton(title: "ตกลง",),
                ),
              ],
            ),
            SizedBox(height: 64,),
          ],
        ),
      ),
    );
  }

}