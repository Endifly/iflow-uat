import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/components/customWidgets/Typography.dart';
import '/contexts/kColors.dart';

typedef void onPressCallback();

class PersonalCard extends StatefulWidget{

  final onPressCallback? onPress;

  PersonalCard({this.onPress});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonalCardState();
  }
}

class _PersonalCardState extends State<PersonalCard> {

  bool isPress = false;

  void onPress() {
    setState(() {
      isPress = true;
    });
  }

  void onUnPress() {
    if (widget.onPress != null) widget.onPress!();
    setState(() {
      isPress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width*0.3,
      child: GestureDetector(
        onTapDown: (t)=>onPress(),
        onTapUp: (t)=>onUnPress(),
        child: Center(
          child: AnimatedContainer(
            height: isPress ? 155:160,
            duration: Duration(milliseconds: 100),
            width: isPress ? MediaQuery.of(context).size.width*0.3-5 : MediaQuery.of(context).size.width*0.3,
            decoration: BoxDecoration(
                color: kColors.pink[400]!.withOpacity(0.8),
                borderRadius: BorderRadius.circular(24),
                boxShadow:[
                  BoxShadow(
                    color: kColors.pink[400]!.withOpacity(0.3),
                    offset: Offset(0,0),
                    blurRadius: 8,
                    spreadRadius: 4,
                  )
                ]
            ),
            child: Center(
              child: Container(
                height: 155,
                width: MediaQuery.of(context).size.width*0.3-5,
                child: Column(
                  children: [
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        SizedBox(
                          height: 72,
                          // width: 64,
                          child: FittedBox(
                            child: IconButton(icon: FaIcon(FontAwesomeIcons.handHoldingHeart),onPressed: ()=>{},),
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                    Spacer(flex: 1,),
                    CTypo(text: "เชิญชวนเพื่อน",color: "secondary",),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}