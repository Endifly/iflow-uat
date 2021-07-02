import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:ios_d1/Provider/ProfileProvider.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LineLogin extends StatelessWidget {

  Future<void> _setUser({required String username,user_id, role,avatarURL}) async {
    print("setting ...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kPrefs.username, username);
    await prefs.setString(kPrefs.userID, user_id);
    await prefs.setString(kPrefs.role, role);
    await prefs.setString(kPrefs.avatarURL, avatarURL);
    await prefs.setDouble(kPrefs.threshold, 60.0);
    print("SharedPreferences ${username}");
  }

  @override
  Widget build(BuildContext context) {

    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    void toHome() {
      Navigator.pushNamed(context, '/home');
    }

    void login() async {
      try {
        final result = await LineSDK.instance.login();
        var profile = result.userProfile;
        if (profile != null) {
          await _setUser(
            username: profile.displayName,
            user_id: profile.userId,
            avatarURL: profile.pictureUrl,
            role: 'free',
          );
          // print(result.userProfile?.displayName);
          profileProvider.setThreshold(70.0);
          toHome();
        }
      } catch (e) {
        // Error handling.
        print(e);
      }
    }

    // TODO: implement build
    return Container(
      child: InkWell(
        // onTap: ()=>sendNotification(title: "line",body:"coming soon"),
        // onTap: ()=>{assetsAudioPlayer.play()},
        onTap: ()=>login(),
        child: ClipOval(
          child: Image.asset(
            "assets/icons/line.png",
            height: 48,
          ),
        ),
      ),
    );
  }

}