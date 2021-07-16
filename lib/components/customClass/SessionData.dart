import 'package:ios_d1/components/customClass/Parser.dart';

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

  static String typeParser(int type) {
    if (type == 0) return 'relax';
    if (type == 1) return 'wandering';
    return 'relax';
  }

  factory SessionData.fromQueryOne(Map<String, dynamic> parsedJson) {
    List<int> parsedRelax = [];
    List<int> parsedWandering = [];

    print(parsedJson['valueRaw']);
    return new SessionData(
        type: typeParser(parsedJson['sessionType']),
        rawRelax: Parser.ListDynaminToListInt(parsedJson['valueRaw'].split(',')),
        threshold: parsedJson['thresholdMax'],
        sessionDate: parsedJson['createdAt'],
        duration: parsedJson['duration']
    );
  }

  factory SessionData.fromQueryAll(Map<String, dynamic> parsedJson) {
    List<int> parsedRelax = [];
    List<int> parsedWandering = [];

    return new SessionData(
        type: typeParser(parsedJson['sessionType']),
        rawRelax: parsedRelax,
        threshold: 0,
        sessionDate: parsedJson['createdAt'],
        duration: parsedJson['duration']
    );
  }

  factory SessionData.fromJson(Map<String, dynamic> parsedJson) {
    print("session datas ${parsedJson}");

    List<int> parsedRelax = [];
    List<int> parsedWandering = [];

    var rawRelax =  parsedJson['rawRelax']?.forEach((e) => parsedRelax.add(e));
    // print("rawRelax : ${parsedRelax[2]} ,rawType : ${parsedRelax.runtimeType}, value type : ${parsedRelax[2].runtimeType}");

    var rawWandering =  parsedJson['rawWandering']?.forEach((e) => parsedWandering.add(e));
    // print("rawWandering : ${rawWandering[2]} ,rawType : ${rawWandering.runtimeType}, value type : ${rawWandering[2].runtimeType}");

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