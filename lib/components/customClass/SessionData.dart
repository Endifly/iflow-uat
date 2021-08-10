import 'package:ios_d1/components/customClass/Parser.dart';

class SessionData {
  final String? id;
  final bool uploaded;
  final String type;
  final List<int> rawRelax;
  final List<int>? rawWandering;
  final List<int>? adaptiveTh;
  final int threshold;
  final int duration;
  final String sessionDate;
  final int average;

  SessionData({
    required this.type,
    required this.rawRelax,
    required this.threshold,
    required this.sessionDate,
    required this.duration,
    this.rawWandering,
    this.adaptiveTh,
    this.id,
    required this.uploaded,
    required this.average,
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
        duration: parsedJson['duration'],
        id: parsedJson['id']?.toString() ?? "",
        uploaded: parsedJson['uploaded'] ?? false,
        average: parsedJson['valueAverage'] ?? 0,
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
        duration: parsedJson['duration'],
        id: parsedJson['id']?.toString() ?? "",
        uploaded: true,
        average: parsedJson['valueAverage'] ?? 0,
    );
  }

  factory SessionData.fromJson(Map<String, dynamic> parsedJson) {
    print("session datas ${parsedJson}");

    List<int> parsedRelax = [];
    List<int> parsedWandering = [];
    List<int> parsedAdaptiveTh = [];

    var rawRelax =  parsedJson['rawRelax']?.forEach((e) => parsedRelax.add(e));
    // print("rawRelax : ${parsedRelax[2]} ,rawType : ${parsedRelax.runtimeType}, value type : ${parsedRelax[2].runtimeType}");

    var rawWandering =  parsedJson['rawWandering']?.forEach((e) => parsedWandering.add(e));
    // print("rawWandering : ${rawWandering[2]} ,rawType : ${rawWandering.runtimeType}, value type : ${rawWandering[2].runtimeType}");

    var rawTh =  parsedJson['adaptiveTh']?.forEach((e) => parsedAdaptiveTh.add(e));

    return new SessionData(
        type: parsedJson['type'] ?? "",
        threshold: parsedJson['threshold'] ?? "",
        rawRelax: parsedRelax,
        rawWandering: parsedWandering,
        sessionDate: parsedJson['sessionDate'] ?? "",
        duration: parsedJson['duration'] ?? "",
        id: parsedJson['id']?.toString() ?? "",
        uploaded: parsedJson['uploaded'] ?? false,
        average: parsedJson['average'] ?? 0,
        adaptiveTh: parsedAdaptiveTh
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": this.type,
      "rawRelax": this.rawRelax,
      "rawWandering": this.rawWandering,
      "adaptiveTh" : this.adaptiveTh,
      "threshold": this.threshold,
      "sessionDate": this.sessionDate,
      "duration" : this.duration,
      "id" : this.id ?? "",
      "uploaded" : this.uploaded,
      "average" : this.average,
    };
  }
}