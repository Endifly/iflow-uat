import 'package:flutter/cupertino.dart';
import 'package:ios_d1/components/customWidgets/HeadsetConnector.dart';

class HeadsetProvider extends ChangeNotifier {
  HeadsetService? headsetService;

  HeadsetProvider({this.headsetService});

  setHeadsetService(HeadsetService hs) {
    headsetService = hs;
    notifyListeners();
  }

}