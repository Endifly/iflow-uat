import 'dart:convert';

import 'package:ios_d1/components/customClass/UserSessions.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UseUserSession {

  UseUserSession();

  Future<UserSessions?> getUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString(kPrefs.userID);
    UserSessions? userSessions;

    if (userID != null) {
      String? userSessionsStore =  prefs.getString(userID);
      if (userSessionsStore != null) {
        var json = jsonDecode(userSessionsStore);
        userSessions = UserSessions.fromJson(json);

      }
    }

    return userSessions;

  }
}