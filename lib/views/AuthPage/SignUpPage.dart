import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_d1/components/DTO/iflowRegisDTO.dart';
import 'package:ios_d1/views/AuthPage/PolicyPage.dart';
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

  String username = "";
  String password = "";
  String phoneNo = "";
  String email = "";



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
        tr('app.register'),
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
      var regisParams = iflowRegisDTO(
        username: this.username,
        email: this.email,
        password: this.password,
        phoneNo: this.phoneNo
      );
      // Navigator.pushNamed(context, '/policy');
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new PolicyPage(
              regisParams: regisParams,
            )),
      );
    }

    void onChangeUsername(String val) {
      setState(() {
        username = val;
      });
    }
    void onChangePassword(String val) {
      setState(() {
        password = val;
      });
    }
    void onChangeEmail(String val) {
      setState(() {
        email = val;
      });
    }
    void onChangePhone(String val) {
      setState(() {
        phoneNo = val;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
          body: Container(
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
                  WhiteTextfield(title:"Username",callback: onChangeUsername),
                  Container(height: 24,),
                  WhiteTextfield(title:"Password",callback: onChangePassword,),
                  PasswordAware(),
                  WhiteTextfield(title:"Mobile No",callback: onChangePhone,),
                  Container(height: 16,),
                  WhiteTextfield(title:"E-mail",callback: onChangeEmail,),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      SizedBox(width: 16,),
                      OrangeCheckbox(onChange: onChange,),
                      SizedBox(width: 16,),
                      CTypo(text: tr('app.autoLogin'),variant: "subtitle1",color: "secondary",),
                    ],
                  ),
                  Container(height: 80,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: OrangeButton(title: tr('app.register'),onPress: toPolicy,),
                  )
                ],
              ),
            ),
          )
        ),
    );
  }
}
