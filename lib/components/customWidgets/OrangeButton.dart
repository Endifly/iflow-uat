import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/components/DecorationConcave.dart';
import 'package:ios_d1/contexts/kColors.dart';

typedef void OnPressCallback();

class OrangeButton extends StatefulWidget {
  final OnPressCallback? onPress;
  final String? title;

  OrangeButton({this.onPress,this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrangeButtonState();
  }

}

class _OrangeButtonState extends State<OrangeButton> {
  bool isPressed = false;
  final PRESSED_BUTTON = ConcaveDecoration(shape:
  RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      depression: 3);

  BoxDecoration NORMAL_BUTTON = BoxDecoration(
      color: Color(0XFFEFF3F6),
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.5,1.0],
          colors: [Colors.amber.withOpacity(0.8), Colors.orangeAccent]),
      borderRadius: BorderRadius.circular(40.0),
      boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            offset: Offset(6, 4),
            blurRadius: 6.0,
            spreadRadius: 4.0)
      ]
  );

  void onpressWrapper(tabdownDetail) {
    setState(() {
      isPressed = true;
    });
  }

  BoxDecoration borderColor = BoxDecoration(
      borderRadius: BorderRadius.circular(40.0),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kColors.yellow[400]!,
            kColors.gold[500]!,
          ]),
      boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            offset: Offset(6, 2),
            blurRadius: 6.0,
            spreadRadius: 1.0),
        BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            offset: Offset(-4, -4),
            blurRadius: 6.0,
            spreadRadius: 4.0)
      ]
  );

  BoxDecoration backgroundOnpress = BoxDecoration(
      borderRadius: BorderRadius.circular(40.0),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kColors.yellow[500]!, Colors.orangeAccent]),
  );

  void onTabCancel(pointerUp) {
    setState(() {
      isPressed = false;
    });
    widget.onPress!();
  }

  Widget _button(context) {
    return Container(
      decoration: backgroundOnpress,
      child: Container(
        height: 44,
        padding: EdgeInsets.all(2),
        decoration: isPressed ? PRESSED_BUTTON : borderColor,
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            widget.title!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black38,
              fontSize: isPressed ? 13.5 : 14
            ),
          ),
          decoration: isPressed ? PRESSED_BUTTON : NORMAL_BUTTON,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Listener(
      // onTap: () => {Navigator.pushNamed(context, '/signup')},
      // onTap: widget.onPress,
      onPointerDown: onpressWrapper,
      onPointerUp: onTabCancel,
      child: _button(context),
    );
  }

}