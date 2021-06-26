import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/DecorationConcave.dart';

typedef void OnPressCallback();

class WhiteButton extends StatefulWidget {
  final OnPressCallback? onPress;
  final String title;

  WhiteButton({required this.title,this.onPress});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WhiteButtonState();
  }

}

class _WhiteButtonState extends State<WhiteButton> {
  bool isPressed = false;

  final PRESSED_BUTTON = ConcaveDecoration(shape:
  RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      depression: 3);

  BoxDecoration NORMAL_BUTTON = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end : Alignment.centerRight,
        colors: [Colors.white,Color.fromRGBO(233, 234, 238, 1),Color.fromRGBO(228, 228, 228, 1)],
        stops: [0.4,0.8,1.0]
    ),
    borderRadius: BorderRadius.circular(40.0),
  );

  BoxDecoration BORDER_COLOR = BoxDecoration(
      borderRadius: BorderRadius.circular(40.0),
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color.fromRGBO(252, 171, 63, 1), Color.fromRGBO(255, 210, 108, 1),Color.fromRGBO(252, 171, 63, 1)]),
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

  BoxDecoration BACKGROUND_COLOR = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end : Alignment.centerRight,
        colors: [Color.fromRGBO(252, 171, 63, 1), Color.fromRGBO(255, 210, 108, 1),Color.fromRGBO(252, 171, 63, 1)],
        stops: [0.4,0.8,1.0]
    ),
    boxShadow: [
      BoxShadow(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          offset: Offset(-4, -4),
          blurRadius: 6.0,
          spreadRadius: 4.0)
    ],
    borderRadius: BorderRadius.circular(40.0),
  );

  void onPressDown(pd) {
    setState(() {
      isPressed = true;
    });
  }

  void onPressUp(pu) {
    setState(() {
      isPressed = false;
    });
    widget.onPress!();
  }

  Widget _button(context) {
    return Container(
      height: 44,
      padding: EdgeInsets.all(2),
      decoration: isPressed ? BACKGROUND_COLOR : BORDER_COLOR,
      child: Container(
        decoration: isPressed ? NORMAL_BUTTON : BoxDecoration(),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Text(
            widget.title,
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
      onPointerDown: onPressDown,
      onPointerUp: onPressUp,
      child: _button(context),
    );
  }

}