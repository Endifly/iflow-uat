import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/DecorationConcave.dart';
import '/components/customWidgets/GraphButton.dart';
import '/contexts/kColors.dart';

typedef void onPressCallback();
typedef void onChangeCallback(bool val);

class OrangeCheckbox extends StatefulWidget {

  final onChangeCallback? onChange;

  OrangeCheckbox({this.onChange});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrangeCheckboxState();
  }
}

class _OrangeCheckboxState extends State<OrangeCheckbox> {

  bool isCheck = false;

  final CONCAVE_DECORATION = ConcaveDecoration(
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      depression: 4,
      colors:[kColors.gold[500]!,Colors.white]
  );

  final BACKGROUND = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: kColors.gold[300]!.withOpacity(0.4)
  );

  void onClick() {
    setState(() {
      isCheck = !isCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BACKGROUND,
        child: Container(
          height: 32,
          width: 32,
          decoration: CONCAVE_DECORATION,
          child: Center(
            child: CheckPoint(checked: isCheck,),
          ),
        ),
      ),
    );
  }
}

class CheckPoint extends StatelessWidget {

  final bool checked;

  CheckPoint({required this.checked});

  BoxBorder CheckpointBorder = Border.all(
    color: kColors.gold[500]!,
    width: 2,
  );

  LinearGradient CheckpointGradient = LinearGradient(
    colors: [kColors.gold[500]!.withOpacity(0.8),kColors.gold[300]!.withOpacity(0.8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        border: checked ? CheckpointBorder : Border(),
        // color: checked ? kColors.gold[500] : Colors.transparent,
        gradient: checked ? CheckpointGradient : null,
        shape: BoxShape.circle,
      ),
    );
  }

}