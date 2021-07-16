class Parser {
  static ListDynaminToListInt(List<dynamic>? vals) {
    try {
      if (vals == null) return [];
      List<int> result = [];
      vals.forEach((e) => result.add(int.parse(e)));
      return result;
    } catch(_) {
      return [];
    }
  }
}