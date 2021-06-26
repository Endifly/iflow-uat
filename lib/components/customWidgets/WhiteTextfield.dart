import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/components/DecorationConcave.dart';
import 'package:ios_d1/contexts/kColors.dart';

// class Textfield extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _TextfieldState();
//   }
// }
typedef void StringCallback(String val);

class WhiteTextfield extends StatelessWidget {
  final StringCallback? callback;
  final String title;

  final CONCAVE_DECORATION = ConcaveDecoration(
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      depression: 4,
      colors:[Colors.grey,Colors.white]
  );

  final BACKGROUND = BoxDecoration(
      // boxShadow: [
      //   BoxShadow(
      //     color: Color.fromRGBO(0, 0, 0, 0.1),
      //     offset: Offset(4,4),
      //     spreadRadius: 1,
      //     blurRadius: 12,
      //   )
      // ],
    gradient: LinearGradient(
      colors: [Colors.white,kColors.silver[500]!.withOpacity(0.1)]
    ),
    borderRadius: BorderRadius.circular(40),

  );


  WhiteTextfield({required this.title,this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final INPUT_DECORATION = InputDecoration(
      filled: true,
      fillColor: Color.fromRGBO(255, 225, 255, 0),
      contentPadding: EdgeInsets.all(12.0),
      hintText: title,
      hintStyle: TextStyle(color: Colors.black38),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      // enabledBorder: UnderlineInputBorder(
      //   borderSide: BorderSide(color: Colors.white),
      //   borderRadius: BorderRadius.circular(32.0),
      // ),
    );

    return Container(
      // height: 40,
      width: 300,
      decoration: BACKGROUND,
      child: Container(
        decoration: CONCAVE_DECORATION,
        child: TextField(
          expands: false,
          onChanged: (text)=>callback!(text),
          style: TextStyle(fontSize: 20.0, color: Colors.black54),
          decoration: INPUT_DECORATION,
        ),
      ),
    );
  }

}