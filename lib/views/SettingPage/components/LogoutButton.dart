import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:ios_d1/components/customWidgets/OrangeButton.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:ios_d1/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatelessWidget {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    void toSelectPage() {
      // Navigator.pushNamed(context, '/select-auth');
      authService.logout(context);
    }

    void handleLogout() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(kPrefs.userID);
      await prefs.remove(kPrefs.username);
      await prefs.remove(kPrefs.avatarURL);
      await prefs.remove(kPrefs.role);
      toSelectPage();
    }

    return OrangeButton(
      title: tr('app.logout'),
      onPress: handleLogout,
    );
  }

}