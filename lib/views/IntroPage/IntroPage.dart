import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/Provider/ProfileProvider.dart';
import 'package:ios_d1/components/customWidgets/OrangeButton.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IntroPageState();
  }
}

class _IntroPageState extends State<IntroPage>{

  bool rendered = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      // 5s over, navigate to a new page
      setState(() {
        rendered = true;
      });
      Navigator.pushNamed(context, "/introduce");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    @override
    initState() async{
      super.initState();
      print("read shapre pref");
      // Timer(Duration(seconds: 3), () {
      //   // 5s over, navigate to a new page
      //   Navigator.pushNamed(context, "/introduce");
      // });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var _th = prefs.getDouble(kPrefs.threshold);
      if (_th != null) {
        profileProvider.setThreshold(_th);
      } else {
        profileProvider.setThreshold(60);
      }
    }

    Widget MenualNext() {
      if (false) {
        return Container(
          margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: InkWell(
            child: OrangeButton(title: "ถัดไป",onPress: ()=>Navigator.pushNamed(context, "/introduce"),),
          ),
        );
      }
      return Container();
    }


    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/main_logo.png"),
              MenualNext(),
            ],
          ),
        ),
      ),
    );
  }

}