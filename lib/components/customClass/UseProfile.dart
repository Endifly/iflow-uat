import 'dart:convert';

import 'package:ios_d1/components/customClass/ProfileQuery.dart';
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

  static Future<void> initProfile(ProfileQuery profileQuery) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kPrefs.username, profileQuery.userName);
    await prefs.setString(kPrefs.userID, profileQuery.userID);
    await prefs.setString(kPrefs.role, profileQuery.role);
    await prefs.setString(kPrefs.firstname, profileQuery.firstName);
    await prefs.setString(kPrefs.lastname, profileQuery.lastName);
    await prefs.setString(kPrefs.avatarURL, profileQuery.pictureURL);
    await prefs.setDouble(kPrefs.threshold, 60.0);
}

}