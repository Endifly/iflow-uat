import 'package:ios_d1/components/customClass/SessionData.dart';

class UserSessions {
  final String userID;
  final List<SessionData> sessions;

  UserSessions({required this.userID,required this.sessions});

  Future init() async {

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
      this.sessions.add(newSessionData);
    }
  }


}