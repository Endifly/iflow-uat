import 'package:flutter/cupertino.dart';

// class mColor {
//   Map<int,Color> asd;
//   mColor({this.asd});
// }

mixin kPrefs implements InheritedWidget {

  static String avatarURL = "avatarURL";
  static String username = "username";
  static String firstname = "firstname";
  static String lastname = "lastname";
  static String threshold = "threshold";
  static String userID = "userID";
  static String accessToken = "accessToken";
  static String role = "role";

  static String userSessions = "userSessions";

  @override
  bool updateShouldNotify(kPrefs oldWidget) => false;
}