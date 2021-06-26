import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/Typography.dart' as Typo;
import '/components/customWidgets/WhiteTextfield.dart';

class MobileNoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MobilNoPageState();
  }
}

class _MobilNoPageState extends State<MobileNoPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.2,),
            Center(
              child: Typo.CTypo(text: "Mobile No",variant: "h6", color: "secondary",)
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            WhiteTextfield(title: "Username",),
            SizedBox(height: 32,),
            WhiteTextfield(title: "Mobile No",),
            Spacer(flex: 1,),
            OrangeButton(title: "ตกลง",),
            SizedBox(height: MediaQuery.of(context).size.height*0.2,),
          ],
        ),
      ),
    );
  }

}