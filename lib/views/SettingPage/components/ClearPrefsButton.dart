import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:ios_d1/components/customWidgets/OrangeButton.dart';
import 'package:ios_d1/components/customWidgets/WhiteButton.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClearPrefsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    void handleLogout() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userID = prefs.getString(kPrefs.userID)!;
      await prefs.remove(userID);
      print("clear user sessions");

    }

    return WhiteButton(
      title: tr('app.clearCache'),
      onPress: handleLogout,
    );
  }

}