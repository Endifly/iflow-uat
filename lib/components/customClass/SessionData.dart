class SessionData {
  final String type;
  final List<int> rawSession;
  final int threshold;
  final int duration;
  final String sessionDate;

  SessionData({
    required this.type,
    required this.rawSession,
    required this.threshold,
    required this.sessionDate,
    required this.duration,
  });

  factory SessionData.fromJson(Map<String, dynamic> parsedJson) {
    print("session datas ${parsedJson}");
    List<int> parsedRawSession = [];
    var rawSession =  parsedJson['rawSession']?.forEach((e) => parsedRawSession.add(e));
    print("rawSession : ${parsedRawSession[2]} ,rawType : ${parsedRawSession.runtimeType}, value type : ${parsedRawSession[2].runtimeType}");
    return new SessionData(
        type: parsedJson['type'] ?? "",
        threshold: parsedJson['threshold'] ?? "",
        rawSession: parsedRawSession,
        sessionDate: parsedJson['sessionDate'] ?? "",
        duration: parsedJson['duration'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": this.type,
      "rawSession": this.rawSession,
      "threshold": this.threshold,
      "sessionDate": this.sessionDate,
      "duration" : this.duration,
    };
  }
}