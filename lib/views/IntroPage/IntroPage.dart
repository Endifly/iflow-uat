import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IntroPageState();
  }
}

class _IntroPageState extends State<IntroPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Timer(Duration(seconds: 3), () {
      // 5s over, navigate to a new page
      Navigator.pushNamed(context, "/introduce");
    });
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image.asset("assets/images/main_logo.png"),
        ),
      ),
    );
  }

}