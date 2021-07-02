import 'package:ios_d1/components/customClass/SessionData.dart';

class UserSessions {
  final String userID;
  final List<SessionData> sessions;

  UserSessions({required this.userID,required this.sessions});

  factory UserSessions.fromJson(Map<String, dynamic> parsedJson) {
    return new UserSessions(
      userID: parsedJson['userID'] ?? "",
      sessions: parsedJson['sessions'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userID": this.userID,
      "sessions": this.sessions,
    };
  }

  void addSession(String type, List<int>? data, int? th) {
    if (data != null) {
      SessionData newSessionData = SessionData(type: type, rawSession: data, threshold: th ?? 60);
      this.sessions.add(newSessionData);
    }
  }
}