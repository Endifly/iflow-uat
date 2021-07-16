import 'dart:convert';
import 'dart:math';

import 'package:ios_d1/components/customClass/SessionData.dart';
import 'package:ios_d1/components/customClass/Stat.dart';
import 'package:ios_d1/components/customClass/UseProfile.dart';
import 'package:ios_d1/components/customClass/UserSessions.dart';
import 'package:ios_d1/contexts/Constant.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:http/http.dart' as http;
import 'package:ios_d1/contexts/kURI.dart';

class SessionDTO {

}

class SessionServices {
  UseProfile profile = UseProfile();
  String userID = "";
  String accessToken = "";

  SessionServices();

  Future initial() async {
    this.userID = await profile.getProlfileString(kPrefs.userID);
    this.accessToken = await profile.getProlfileString(kPrefs.accessToken);
  }

  Future<http.Response> putSession({required SessionData session}) {
    print("verify token : ${kURI.BACKEND}");
    print('auth : ${this.accessToken}');
    return http.put(
      Uri.http(kURI.BACKEND, '/session/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${this.accessToken}'
      },
      body: jsonEncode(<String, dynamic>{
        'type': 0,
        'duration': session.duration,
        'alarmCount': 5,
        'value' : {
          'raw' : session.rawRelax.join(","),
          'max' : session.rawRelax.reduce(max),
          'min' : session.rawRelax.reduce(min),
          'average': Stat.average(session.rawRelax),
          'sd' : Stat.sd(session.rawRelax),
        },
        'threshold' : {
          'adaptive' : '',
          'max' : session.threshold,
        }
      }),
    );
  }

  Future uploadOneSession(SessionData session) async{
    // print("upload session");
    var res = await putSession(session: session);
    print("put session : ${res.body}");
    return res.body;
  }

  Future<http.Response> getAllSession() {
    print('auth : ${this.accessToken}');
    return http.get(
      Uri.http(kURI.BACKEND, '/session'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${this.accessToken}'
      },
    );
  }

  Future sessions() async{
    var res = await getAllSession();
    print(res.body);
    UserSessions userSessions = new UserSessions(userID:this.userID);
    List<dynamic> sessions = jsonDecode(res.body);
    // print("load sessions : ${sessions[0]['id']}");
    sessions.forEach((session) {
      SessionData sdto = SessionData.fromQueryAll(session);
      userSessions.addSessionData(sdto);
    });
    return userSessions;
  }

  Future<http.Response> getSession(String id) {
    return http.get(
      Uri.http(kURI.BACKEND, '/session/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${this.accessToken}'
      },
    );
  }

  Future<SessionData> session(String id) async {
    var res = await getSession(id);
    UserSessions userSessions = new UserSessions(userID:this.userID);

    dynamic session = jsonDecode(res.body);
    SessionData newSessionData = new SessionData.fromQueryOne(session);
    userSessions.addSessionData(newSessionData);

    return newSessionData;
  }

}