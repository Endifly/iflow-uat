import 'dart:convert';

import 'package:ios_d1/components/customClass/SessionData.dart';
import 'package:ios_d1/components/customClass/Stat.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:ios_d1/services/SessionService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSessions {
  String? userID;
  List<SessionData>? sessions;
  List<SessionData>? localSession;

  UserSessions({this.sessions,this.userID});

  Future sync() async {
    SessionServices sessionServices = new SessionServices();
    await sessionServices.initial();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userID = prefs.getString(kPrefs.userID)!;
    String? userSessionsStore =  prefs.getString(this.userID!);
    UserSessions? localUserSessions;
    var json;
    if (userSessionsStore != null) {
      json = jsonDecode(userSessionsStore);
      localUserSessions = UserSessions.fromJson(json);
    }

    // print("user session loaded");
   if (localUserSessions?.sessions == null) {
     this.sessions = [];
   } else {
     this.sessions = localUserSessions!.sessions!;
   }

   print("local session : ${localUserSessions?.sessions}");
   // print(onlineUserSessions?.sessions);

   UserSessions onlineUserSessions = await sessionServices.sessions();
   if (onlineUserSessions.sessions != null) {
     this.sessions = this.sessions! + onlineUserSessions.sessions!;
   }

    // onlineUserSessions?.sessions?.forEach((session) {
    //   this.sessions = this.sessions + on
    // });
    // this.sessions?.forEach((element) {
    //   print(element.uploaded);
    // });
  }

  Future save() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString(kPrefs.userID)!;
    print("on savev ${userID} , data : ${jsonEncode(this)}");
    await prefs.setString(userID, jsonEncode(this));
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
      "sessions": this.localSession,
    };
  }

  void addLocalSession(SessionData sessionData) {
    List<SessionData> tmp = [];
    if (this.sessions != null) {
      this.sessions!.forEach((s) {
        if (s.uploaded == false) {
          tmp.add(s);
        }
      });
    }
    tmp.add(sessionData);
    this.localSession = tmp;
  }

  void addRelax(List<int>? data, int? th,int du) {
    if (data != null) {
      SessionData newSessionData = SessionData(
          type: 'relax',
          rawRelax: data,
          threshold: th ?? 60,
          sessionDate: (new DateTime.now().toString()),
          duration: du,
          uploaded: false,
          average: Stat.average(data).toInt(),
      );
      // this.sessions.add(newSessionData);
      addLocalSession(newSessionData);
      // if (this.sessions != null) {
      //   this.sessions!.add(newSessionData);
      // }
    }
  }

  void addWandering(
      {List<int>? relax, List<int>? wandering, int? th_r, int? th_w, required int du}) {
    // if (relax != null) {
      SessionData newSessionData = SessionData(
        type: 'wandering',
        rawRelax: relax ?? [],
        rawWandering: wandering ?? [],
        threshold: th_r ?? 60,
        sessionDate: (new DateTime.now().toString()),
        duration: du,
        uploaded: false,
        average: Stat.average(relax ?? []).toInt(),
      );
      // this.sessions.add(newSessionData);
      addLocalSession(newSessionData);
      // if (this.sessions != null) {
      //   this.sessions!.add(newSessionData);
      // }
    // }
  }

  void addSessionData(SessionData newSessionData) {
    if (this.sessions != null) {
      this.sessions!.add(newSessionData);
    } else {
      this.sessions = [newSessionData];
    }
  }

}