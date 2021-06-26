import 'package:flutter/cupertino.dart';

// class mColor {
//   Map<int,Color> asd;
//   mColor({this.asd});
// }

mixin kColors implements InheritedWidget {

  static Color transparent = Color.fromRGBO(0, 0, 0, 0);
  
  static Map<int,Color> silver= {
    500: Color.fromRGBO(222, 224, 229, 1),
  };
  
  static Map<int,Color> yellow={
    100:Color.fromRGBO(248, 246, 221, 1),
    200:Color.fromRGBO(247, 241, 187, 1),
    300:Color.fromRGBO(246, 236, 155, 1),
    400:Color.fromRGBO(244, 230, 128, 1),
    500:Color.fromRGBO(244, 225, 96, 1),
  };

  static Map<int,Color> gold={
    100:Color.fromRGBO(255, 247, 221, 1),
    200:Color.fromRGBO(245, 225, 166, 1),
    300:Color.fromRGBO(244, 216, 129, 1),
    400:Color.fromRGBO(241, 207, 91, 1),
    500:Color.fromRGBO(239, 198, 36, 1),
  };

  static Map<int,Color> orange={
    100:Color.fromRGBO(246, 222, 196, 1),
    200:Color.fromRGBO(242, 197, 152, 1),
    300:Color.fromRGBO(238, 174, 116, 1),
    400:Color.fromRGBO(234, 152, 75, 1),
    500:Color.fromRGBO(230, 132, 35, 1),
  };

  static Map<int,Color> black={
    100:Color.fromRGBO(208, 210, 211, 1),
    200:Color.fromRGBO(170, 172, 175, 1),
    300:Color.fromRGBO(134, 136, 139, 1),
    400:Color.fromRGBO(105, 106, 108, 1),
    500:Color.fromRGBO(64, 64, 65, 1),
  };

  static Map<int,Color> pink={
    100:Color.fromRGBO(248, 235, 241, 1),
    200:Color.fromRGBO(245, 222, 223, 1),
    300:Color.fromRGBO(244, 210, 226, 1),
    400:Color.fromRGBO(241, 196, 218, 1),
    500:Color.fromRGBO(240, 184, 210, 1),
  };

  static Map<int,Color> green={
    100:Color.fromRGBO(223, 238, 232, 1),
    200:Color.fromRGBO(198, 227, 217, 1),
    300:Color.fromRGBO(174, 217, 203, 1),
    400:Color.fromRGBO(148, 208, 189, 1),
    500:Color.fromRGBO(128, 199, 176, 1),
  };

  static Map<int,Color> coral={
    100:Color.fromRGBO(248, 221, 209, 1),
    200:Color.fromRGBO(246, 194, 175, 1),
    300:Color.fromRGBO(244, 168, 144, 1),
    400:Color.fromRGBO(241, 143, 121, 1),
    500:Color.fromRGBO(239, 124, 91, 1),
  };

  static Map<int,Color> blue={
    100:Color.fromRGBO(206, 208, 231, 1),
    200:Color.fromRGBO(168, 174, 214, 1),
    300:Color.fromRGBO(134, 144, 197, 1),
    400:Color.fromRGBO(108, 124, 183, 1),
    500:Color.fromRGBO(76, 102, 171, 1),
  };


  @override
  bool updateShouldNotify(kColors oldWidget) => false;
}