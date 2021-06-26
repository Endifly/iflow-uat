import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VolumeButton extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VolumeButtonState();
  }
}

class _VolumeButtonState extends State<VolumeButton> {
  @override
  bool isExpand = false;
  bool isMute = false;
  bool showAllVolume = false;

  void toggleShowAllVolume () {
    setState(() {
      showAllVolume = !showAllVolume;
    });
  }

  void onClickVolume() {
    if (!isExpand) {
      setState(() {
        isExpand = true;
      });
      var timer = new Timer(const Duration(milliseconds: 200), toggleShowAllVolume);
    }
  }

  void collapse() {
    setState(() {
      isExpand = false;
    });
  }

  void toggleVoice() {
    // if (!isExpand) return
    print("mute swap");
    setState(() {
      isMute = !isMute;
    });
    new Timer(const Duration(milliseconds: 0), toggleShowAllVolume);
    new Timer(const Duration(milliseconds: 0), collapse);
  }

  List<Widget> notExpandWidget() {
    if (isMute) return [IconButton(onPressed: onClickVolume, icon: FaIcon(FontAwesomeIcons.volumeMute))];
    return [IconButton(onPressed: onClickVolume, icon: FaIcon(FontAwesomeIcons.volumeUp))];
  }

  List<Widget> expandWidget() {
    if (isMute) {
      return [
        IconButton(onPressed: toggleVoice, icon: FaIcon(FontAwesomeIcons.volumeUp)),
        IconButton(onPressed: toggleVoice, icon: FaIcon(FontAwesomeIcons.volumeMute)),
      ];
    }
    // if (!isMute) {
      return [
        IconButton(onPressed: toggleVoice, icon: FaIcon(FontAwesomeIcons.volumeMute)),
        IconButton(onPressed: toggleVoice, icon: FaIcon(FontAwesomeIcons.volumeUp)),
      ];
    // }
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      // onTap: isExpand ? ()=>{}:onClickVolume,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(0,4),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: isExpand ? 128:48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: showAllVolume ? expandWidget() :notExpandWidget(),
          ),
        ),
      ),
    );
  }

}