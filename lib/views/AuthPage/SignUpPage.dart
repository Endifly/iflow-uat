import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/DecorationConcave.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/OrangeCheckbox.dart';
import '/components/customWidgets/Typography.dart';
import '/components/customWidgets/WhiteTextfield.dart';
import '/contexts/kColors.dart';
// import 'package:iflow/components/DecorationConcave.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  @override



  final BACKGROUND = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white,kColors.silver[500]!.withOpacity(0.5)]
      )
  );

  void onChange(bool checked) {
    print("onchange");
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    // final innerShadow = ConcaveDecoration(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(40.0),
    //     ),
    //     depth: 10.0,
    // );
    void onSignUp() {
      Navigator.pushNamed(context, '/signup');
    }

    Widget Title() {
      return Text(
        "สมัคร",
        style: TextStyle(
            fontSize: 33,
            color: Colors.grey
        ),
      );
    }

    Widget PasswordAware() {
      return (
          Container(
            width: 300,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 16, 0, 16),
                child: Text(
                  "อย่างน้อย 8 ตัวอักษร",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          )
      );
    }

    void toPolicy() {
      Navigator.pushNamed(context, '/policy');
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
          body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          decoration: BACKGROUND,
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width*0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Title(),
                  Container(height: 80,),
                  WhiteTextfield(title:"Username"),
                  Container(height: 24,),
                  WhiteTextfield(title:"Password"),
                  PasswordAware(),
                  WhiteTextfield(title:"Mobile No"),
                  Container(height: 16,),
                  WhiteTextfield(title:"E-mail"),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      SizedBox(width: 16,),
                      OrangeCheckbox(onChange: onChange,),
                      SizedBox(width: 16,),
                      CTypo(text: "เข้าระบบโดยอัตโนมัติ",variant: "subtitle1",color: "secondary",),
                    ],
                  ),
                  Container(height: 80,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: OrangeButton(title: "สมัคร",onPress: toPolicy,),
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
