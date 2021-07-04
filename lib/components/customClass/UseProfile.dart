import 'dart:convert';

import 'package:ios_d1/components/customClass/UserSessions.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UseProfile {

  UseProfile();

  Future<String> getAvatarURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? avatarURL = prefs.getString(kPrefs.avatarURL);
    if (avatarURL == null) return "assets/images/person_2.png";
    return avatarURL;
  }

  Future<double> getThreshold() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? th = prefs.getDouble(kPrefs.threshold);
    return th ?? 60.0;
  }

  Future<String> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString(kPrefs.userID);
    return userID ?? "";
  }

}