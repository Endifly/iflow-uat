import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ios_d1/components/DTO/iflowRegisDTO.dart';
import 'package:ios_d1/services/AuthService.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/OrangeCheckbox.dart';
import '/components/customWidgets/Typography.dart';

class PolicyPage extends StatefulWidget {
  final iflowRegisDTO? regisParams;

  PolicyPage({this.regisParams});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PolicyPageState();
  }

}

class _PolicyPageState extends State<PolicyPage> {
  String policy = "";

  Future<String> loadPolicy() async {
    return await rootBundle.loadString('assets/policy/policy.txt');
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  void _setup() async {
    String _policy = await loadPolicy();
    // print(_policy);
    setState(() {
      policy = _policy;
    });
  }

  void onRegis() async {
    print(widget.regisParams?.username);
    if (widget.regisParams != null ) {
      AuthService.iflowRegis(widget.regisParams!);
      Navigator.pushNamed(context, '/select-auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width*0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("นโยบายการให้บริการ",style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 32,),
                PolicyView(policy: policy,),
                SizedBox(height: 32,),
                Row(
                  children: [
                    SizedBox(width: 16,),
                    OrangeCheckbox(),
                    SizedBox(width: 16,),
                    CTypo(text: "ยอมรับนโยบายการให้บริการ",variant: "subtitle2",color: "secondary",),
                  ],
                ),
                SizedBox(height: 32,),
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: OrangeButton(title: "ถัดไป",onPress: onRegis,),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

class PolicyView extends StatelessWidget {
  final String policy;
  final ScrollController _scrollController = ScrollController();
  PolicyView({required this.policy});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height*0.6,
      child: Scrollbar(
        isAlwaysShown: true,
        radius: Radius.circular(16),

        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(policy),
            ),
          ],
        ),
      )
    );
  }

}