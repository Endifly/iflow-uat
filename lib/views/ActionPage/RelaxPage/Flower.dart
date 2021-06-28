import 'dart:async';

import 'package:flutter/cupertino.dart';

class Flower extends StatefulWidget {
  final flowerState;
  int? slowFactor = 1;

  Flower({this.flowerState,this.slowFactor}) ;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FlowerState();
  }
}

class _FlowerState extends State<Flower> with TickerProviderStateMixin {
  var flowerVisibleState = [false,false,false,false,false];

  // var slowFactor = 2;

  Animation? flowert_1_scale_animation;
  AnimationController? flowert_1_scale_controller;

  Animation? flowert_2_scale_animation;
  AnimationController? flowert_2_scale_controller;

  Animation? flowert_3_scale_animation;
  AnimationController? flowert_3_scale_controller;

  Animation? flowert_4_scale_animation;
  AnimationController? flowert_4_scale_controller;

  Animation? flowert_leaf_scale_animation;
  AnimationController? flowert_leaf_scale_controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    flowert_1_scale_controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2500*widget.slowFactor!),);
    flowert_1_scale_animation = Tween(begin: 1.0,end:1.7).animate(flowert_1_scale_controller!);

    flowert_2_scale_controller = AnimationController(vsync: this, duration: Duration(seconds: 2*widget.slowFactor!),);
    flowert_2_scale_animation = Tween(begin: 1.2,end:1.5).animate(flowert_2_scale_controller!);

    flowert_3_scale_controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1500*widget.slowFactor!),);
    flowert_3_scale_animation = Tween(begin: 1.0,end:1.2).animate(flowert_3_scale_controller!);

    flowert_4_scale_controller = AnimationController(vsync: this, duration: Duration(seconds: 4*widget.slowFactor!),);
    flowert_4_scale_animation = Tween(begin: 1.2,end:1.5).animate(flowert_4_scale_controller!);

    flowert_leaf_scale_controller = AnimationController(vsync: this, duration: Duration(seconds: 3*widget.slowFactor!),);
    flowert_leaf_scale_animation = Tween(begin: 0.7,end:1.2).animate(flowert_leaf_scale_controller!);
  }

  void handleChangeState() {
    switch(widget.flowerState) {
      case 0 :
        flowert_3_scale_controller!.reverse();
        flowert_4_scale_controller!.reverse();
        flowert_2_scale_controller!.reverse();
        flowert_1_scale_controller!.reverse();
        break;
      case 1 :
        setState(() {
          flowert_leaf_scale_controller!.reverse();

          flowerVisibleState[0] = true;
          flowert_1_scale_controller!.forward();
        });
        break;
      case 2 :
        setState(() {
          // flower_1_visible = false;
          flowerVisibleState[1] = true;
          flowerVisibleState[0] = false;
          flowert_2_scale_controller!.forward();
        });
        break;
      case 3 :
        setState(() {
          // flowert_2_scale_controller.forward();
          flowerVisibleState[1] = false;
          flowerVisibleState[2] = true;
          flowert_3_scale_controller!.forward();
        });
        break;
      case 4 :
        setState(() {
          flowerVisibleState[2] = false;
          flowerVisibleState[3] = true;
          flowert_2_scale_controller!.reverse();
          flowert_4_scale_controller!.forward();
        });
        break;
      case 5 :
        setState(() {
          flowert_leaf_scale_controller!.forward();
          flowerVisibleState[4] = true;
        });
        break;
      case 7 :
        setState(() {
          // flowert_4_scale_controller.forward();
          // flowert_leaf_scale_controller.reverse();
          flowerVisibleState[4] = false;
          flowerVisibleState[3] = false;
        });
        break;
      default :
        break;
    }
  }

  Widget flower1(context) {
    return AnimatedOpacity(
        opacity: flowerVisibleState[0] ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: AnimatedBuilder(
          animation: flowert_1_scale_controller!,
          builder: (context,child)=>Transform.scale(
            scale: flowert_1_scale_animation!.value,
            child: ClipOval(
              child: Image.asset("assets/images/flower1.png", height: 256,),
            ),
          ),
        )
    );
  }

  Widget flower2(context) {
    return AnimatedOpacity(
        opacity: flowerVisibleState[1] ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: AnimatedBuilder(
          animation: flowert_2_scale_controller!,
          builder: (context,child)=>Transform.scale(
            scale: flowert_2_scale_animation!.value,
            child: ClipOval(
              child: Image.asset("assets/images/flower2.png", height: 256,),
            ),
          ),
        )
    );
  }

  Widget flower3(context) {
    return AnimatedOpacity(
        opacity: flowerVisibleState[2] ? 1.0 : 0.0,
        duration: Duration(milliseconds: 800),
        child: AnimatedBuilder(
          animation: flowert_3_scale_controller!,
          builder: (context,child)=>Transform.scale(
            scale: flowert_3_scale_animation!.value,
            child: ClipOval(
              child: Image.asset("assets/images/flower3.png", height: 256,),
            ),
          ),
        )
    );
  }

  Widget flower4(context) {
    return AnimatedOpacity(
        opacity: flowerVisibleState[3] ? 1.0 : 0.0,
        duration: Duration(milliseconds: 2000),
        child: AnimatedBuilder(
          animation: flowert_4_scale_controller!,
          builder: (context,child)=>Transform.scale(
            scale: flowert_4_scale_animation!.value,
            child: ClipOval(
              child: Image.asset("assets/images/flower4.png", height: 256,),
            ),
          ),
        )
    );
  }

  Widget flower5(context) {
    return AnimatedOpacity(
        opacity: flowerVisibleState[4] ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: AnimatedBuilder(
          animation: flowert_leaf_scale_controller!,
          builder: (context,child)=>Transform.scale(
            scale: flowert_leaf_scale_animation!.value,
            child: ClipOval(
              child: Image.asset("assets/images/flower_leaf1.png", height: 256,),
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // print(widget.flowerState);
    handleChangeState();
    return Container(
      // child: Image.asset("assets/images/flower${widget.flowerState}.png", height: 256,),
      child: Stack(
        alignment: Alignment.center,
        children: [
          flower1(context),
          flower2(context),
          flower3(context),
          flower4(context),
          flower5(context),
        ],
      )
    );
  }

}