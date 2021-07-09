import 'dart:convert';

import 'package:ios_d1/components/customClass/SessionData.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSessions {
  String? userID;
  List<SessionData>? sessions;

  UserSessions({this.sessions,this.userID});

  Future sync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userID = prefs.getString(kPrefs.userID)!;
    String? userSessionsStore =  prefs.getString(this.userID!);

    UserSessions? userSessions;
    var json;
    if (userSessionsStore != null) {
      // print("loading user session : ${userSessionsStore}");
      json = jsonDecode(userSessionsStore);
      userSessions = UserSessions.fromJson(json);
      // print("before loaded : ${userSessions}");
      // print("loaded user session : ${userSessions.userID} ${userSessions.sessions}");
    }

    // print("user session loaded");
   if (userSessions?.sessions == null) {
     this.sessions = [];
   } else {
     this.sessions = userSessions!.sessions!;
   }
  }

  List<SessionData> loadSessionDaraFromJson(dynamic tmp) {
    List<SessionData> result = [];
    for (dynamic session in tmp) {
      SessionData sessionData = SessionData.fromJson(session);
      result.add(sessionData);
    }
    return result;
  }

  factory UserSessions.fromJson(Map<String, dynamic> parsedJson) {
    print("load user sesssion");
    List<SessionData> results = [];
    for (dynamic session in parsedJson['sessions']) {
      SessionData sessionData = SessionData.fromJson(session);
      results.add(sessionData);
      print("cc ${sessionData}");
    }
    print("pares result ${results}");
    return new UserSessions(
      userID: parsedJson['userID'] ?? "",
      sessions: results as List<SessionData>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userID": this.userID,
      "sessions": this.sessions,
    };
  }

  void addRelax(List<int>? data, int? th,int du) {
    if (data != null) {
      SessionData newSessionData = SessionData(
          type: 'relax',
          rawRelax: data,
          threshold: th ?? 60,
          sessionDate: (new DateTime.now().toString()),
          duration: du,
      );
      // this.sessions.add(newSessionData);
      if (this.sessions != null) {
        this.sessions!.add(newSessionData);
      }
    }
  }


}