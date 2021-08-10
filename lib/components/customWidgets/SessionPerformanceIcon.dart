import 'package:flutter/cupertino.dart';
import 'package:ios_d1/components/customClass/Stat.dart';

class SessionPerformanceIcon extends StatelessWidget {
  final List<int>? relax;
  final List<int>? wandering;

  SessionPerformanceIcon({this.wandering,this.relax});

  @override
  Widget build(BuildContext context) {

    Widget getRelaxPerformanceIcon(List<int> relaxScore) {
      print("get relax");
      var score = Stat.average(relaxScore);
      if (score <= 45) return Image.asset("assets/images/sun1.png");
      if (score <= 50 && score > 45) return Image.asset("assets/images/sun2.png");
      if (score <= 55 && score > 50) return Image.asset("assets/images/sun3.png");
      if (score > 55) return Image.asset("assets/images/sun4.png");
      return Image.asset("assets/images/sun4.png");
    }

    Widget getWanderingPerformanceIcon(List<int> relaxScore,List<int> wanderingScore) {
      print("get wandering");
      var avr = Stat.average(wanderingScore);
      var avw = Stat.average(relaxScore);

      print("avr : ${avr},avw : ${avw}");

      if (avr < 45) {
        if (avw < 40) return Image.asset("assets/images/glum1.png");
        if (avw < 60) return Image.asset("assets/images/glum0.png");
        return Image.asset("assets/images/clound1.png");
      }
      if (avr < 55) {
        if (avw < 40) return Image.asset("assets/images/sun2.png");
        if (avw < 60) return Image.asset("assets/images/sun1.png");
        return Image.asset("assets/images/clound2.png");
      }
      if (avr < 100) {
        if (avw < 40) return Image.asset("assets/images/sun4.png");
        if (avw < 60) return Image.asset("assets/images/sun3.png");
        return Image.asset("assets/images/clound2.png");
      }
      return Image.asset("assets/images/logo50.png");
    }

    Widget getIcon() {
      if (this.relax == null) return Text("invalid data");
      if (this.wandering == null) return getRelaxPerformanceIcon(this.relax!);
      return getWanderingPerformanceIcon(this.relax!, this.wandering!);
    }

    // TODO: implement build
    return Container(
      child: getIcon(),
    );
  }

}