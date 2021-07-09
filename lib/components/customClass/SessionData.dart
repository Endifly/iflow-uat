class SessionData {
  final String type;
  final List<int> rawRelax;
  final List<int>? rawWandering;
  final int threshold;
  final int duration;
  final String sessionDate;

  SessionData({
    required this.type,
    required this.rawRelax,
    required this.threshold,
    required this.sessionDate,
    required this.duration,
    this.rawWandering,
  });

  factory SessionData.fromJson(Map<String, dynamic> parsedJson) {
    print("session datas ${parsedJson}");

    List<int> parsedRelax = [];
    List<int> parsedWandering = [];

    var rawRelax =  parsedJson['rawRelax']?.forEach((e) => parsedRelax.add(e));
    print("rawRelax : ${parsedRelax[2]} ,rawType : ${parsedRelax.runtimeType}, value type : ${parsedRelax[2].runtimeType}");

    var rawWandering =  parsedJson['rawWandering']?.forEach((e) => parsedWandering.add(e));
    print("rawWandering : ${rawWandering[2]} ,rawType : ${rawWandering.runtimeType}, value type : ${rawWandering[2].runtimeType}");

    return new SessionData(
        type: parsedJson['type'] ?? "",
        threshold: parsedJson['threshold'] ?? "",
        rawRelax: parsedRelax,
        rawWandering: parsedWandering,
        sessionDate: parsedJson['sessionDate'] ?? "",
        duration: parsedJson['duration'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": this.type,
      "rawRelax": this.rawRelax,
      "rawWandering": this.rawWandering,
      "threshold": this.threshold,
      "sessionDate": this.sessionDate,
      "duration" : this.duration,
    };
  }
}