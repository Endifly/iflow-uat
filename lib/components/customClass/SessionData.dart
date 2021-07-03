class SessionData {
  final String type;
  final List<int> rawSession;
  final int threshold;

  SessionData({required this.type,required this.rawSession,required this.threshold});

  factory SessionData.fromJson(Map<String, dynamic> parsedJson) {
    print("session datas ${parsedJson}");
    return new SessionData(
        type: parsedJson['type'] ?? "",
        threshold: parsedJson['threshold'] ?? "",
        rawSession: parsedJson['rawSession'] as List<int>,
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