import 'dart:math';

class Stat {
  static double average(List<int> values) {
    return values.reduce((a, b) => a + b) / values.length;
  }

  static double sd(List<int> values) {
    var avr = average(values);
    var valuesCount = values.length;
    var sum = 0.0;
    values.forEach((x) {
      var delta = pow(x-avr, 2);
      sum += delta;
    });
    var _sd = sqrt(sum/valuesCount);
    return _sd;
  }
}