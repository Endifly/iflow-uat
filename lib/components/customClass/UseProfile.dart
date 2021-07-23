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

  Future<String> getProlfileString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? val = prefs.getString(key);
    return val ?? "";
  }

  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? val = prefs.getString(kPrefs.accessToken);
    return val ?? "";
  }

  static Future<void> initProfile(ProfileQuery profileQuery) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kPrefs.username, profileQuery.userName);
    await prefs.setString(kPrefs.userID, profileQuery.userID);
    await prefs.setString(kPrefs.role, profileQuery.role);
    await prefs.setString(kPrefs.firstname, profileQuery.firstName);
    await prefs.setString(kPrefs.lastname, profileQuery.lastName);
    await prefs.setString(kPrefs.avatarURL, profileQuery.pictureURL);
    await prefs.setString(kPrefs.accessToken, profileQuery.accessToken);
    await prefs.setString(kPrefs.type, profileQuery.type);
    await prefs.setDouble(kPrefs.threshold, 60.0);
  }

  Future clearProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(kPrefs.username);
    await prefs.remove(kPrefs.userID);
    await prefs.remove(kPrefs.role);
    await prefs.remove(kPrefs.firstname);
    await prefs.remove(kPrefs.lastname);
    await prefs.remove(kPrefs.avatarURL);
    await prefs.remove(kPrefs.accessToken);
    await prefs.remove(kPrefs.threshold);
    await prefs.remove(kPrefs.type);
  }

}