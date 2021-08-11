import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/Provider/ProfileProvider.dart';
import 'package:ios_d1/components/customClass/Loader.dart';
import 'package:ios_d1/components/customClass/UseProfile.dart';
import 'package:ios_d1/components/customWidgets/OrangeButton.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:ios_d1/services/AuthService.dart';
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
  UseProfile profile = UseProfile();
  AuthService authService = AuthService();

  void toHome() {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  void authGuard() async {
    var me = await authService.queryMe();
    print("queryMe ${me.userID}");
    if (me.userID != "") Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
    else Navigator.pushNamedAndRemoveUntil(context, "/introduce", (route) => false);
  }

  void timeOut() async {
    print("timeout");
    Future.delayed(Duration(seconds: 3),toHome);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authGuard();
    timeOut();
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
      return Container(
        child: ElevatedButton(
          onPressed: ()=>toHome(),
          child: Text("by pass"),
        ),
      );
    }


    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/main_logo.png"),
              Loader.circleLoader,
              MenualNext(),
            ],
          ),
        ),
      ),
    );
  }

}