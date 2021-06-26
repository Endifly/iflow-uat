import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/DecorationConcave.dart';
import '/contexts/kColors.dart';

// class Textfield extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _TextfieldState();
//   }
// }
typedef void StringCallback(String val);

class OrangeTextfield extends StatelessWidget {
  final StringCallback? callback;
  final String? title;
  final bool? password;
  final CONCAVE_DECORATION = ConcaveDecoration(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      depression: 3,
      colors: [kColors.orange[400]!,Colors.white]
  );



  OrangeTextfield({this.title,this.callback,this.password});

  bool isPasswordField() {
    if (password == null) return false;
    if (password is bool) return password!;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    InputDecoration INPUT_DECORATION = InputDecoration(
      filled: true,
      fillColor: Color.fromRGBO(255, 234 , 185, 0.5),
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
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(32.0),
      ),
    );
    return Container(
      // height: 40,
      decoration: CONCAVE_DECORATION,
      child: TextField(
        expands: false,
        onChanged: (text) => callback!(text),
        style: TextStyle(fontSize: 20.0, color: Colors.black54),
        obscureText: isPasswordField(),
        obscuringCharacter: "*",
        decoration: INPUT_DECORATION,
      ),
    );
  }

}