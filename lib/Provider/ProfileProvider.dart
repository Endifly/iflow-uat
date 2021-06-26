import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  String accessToken;
  double threshold;

  ProfileProvider({required this.accessToken,required this.threshold});

  setToken(String token) {
    accessToken = token;
    notifyListeners();
  }

  setThreshold(double th) {
    threshold = th;
    notifyListeners();
  }
}