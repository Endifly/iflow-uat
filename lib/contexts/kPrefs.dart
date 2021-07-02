import 'package:flutter/cupertino.dart';

// class mColor {
//   Map<int,Color> asd;
//   mColor({this.asd});
// }

mixin kPrefs implements InheritedWidget {

  static String avatarURL = "avatarURL";
  static String username = "username";
  static String threshold = "threshold";
  static String userID = "user_id";
  static String role = "role";

  static String userSessions = "userSessions";

  @override
  bool updateShouldNotify(kPrefs oldWidget) => false;
}