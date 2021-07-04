class SessionData {
  final String type;
  final List<int> rawSession;
  final int threshold;

  SessionData({required this.type,required this.rawSession,required this.threshold});

  void loadRawSession(dynamic json) {
    List<dynamic> rawSession =  json['rawSession'];
    print("rawSession : ${rawSession[2]}");
  }

  factory SessionData.fromJson(Map<String, dynamic> parsedJson) {
    print("session datas ${parsedJson}");
    List<int> parsedRawSession = [];
    var rawSession =  parsedJson['rawSession']?.forEach((e) => parsedRawSession.add(e));
    print("rawSession : ${parsedRawSession[2]} ,rawType : ${parsedRawSession.runtimeType}, value type : ${parsedRawSession[2].runtimeType}");
    return new SessionData(
        type: parsedJson['type'] ?? "",
        threshold: parsedJson['threshold'] ?? "",
        rawSession: parsedRawSession,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": this.type,
      "rawSession": this.rawSession,
      "threshold": this.threshold,
    };
  }
}