import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:ios_d1/Provider/ProfileProvider.dart';
import 'package:ios_d1/components/customClass/ProfileQuery.dart';
import 'package:ios_d1/components/customClass/UseProfile.dart';
import 'package:ios_d1/contexts/Constant.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FacebookLoginButton extends StatelessWidget {

  static final FacebookLogin facebookSignIn = new FacebookLogin();
  UseProfile profile = UseProfile();

  void _showMessage(String message) {
    print(message);
  }

  @override
  Widget build(BuildContext context) {

    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    void toHome() {
      Navigator.pushNamed(context, '/home');
    }

    Future<Null> _logOut() async {
      await facebookSignIn.logOut();
      _showMessage('Logged out.');
    }

    Future<http.Response> _verifyToken({required String token}) {
      print("verify token : ${MyConstants.of(context)!.REST_URI}");
      return http.post(
        Uri.http(MyConstants.of(context)!.REST_URI, 'auth/facebook'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'token': token,
        }),
      );
    }


    Future<void> initUser(ProfileQuery profileQuery) async {
      print("setting ...");
      if (profileQuery == null) return ;

      await UseProfile.initProfile(profileQuery);

      profileProvider.setToken(profileQuery.accessToken);
      profileProvider.setThreshold(60.0);

      var userID = await profile.getUserID();
      print("SharedPreferences ${userID}");

      toHome();
    }

    Future onUserSignIn({required String token}) async {
      var res = await _verifyToken(token: token);
      var body = res.body;
      print(body);
      ProfileQuery profile = ProfileQuery.fromJson(jsonDecode(body));
      print(profile.pictureURL);
      initUser(profile);
    }

    Future<Null> _login() async {
      print("start login ...");
      final FacebookLoginResult result = await facebookSignIn.logIn(['email','public_profile']);

      print("logged in ... ${result.status}");
      print(result.errorMessage);
      // print(result.accessToken.token);
      // onSubmit();
      print(result.status);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
          await onUserSignIn(token: accessToken.token);

          break;
        case FacebookLoginStatus.cancelledByUser:
          _showMessage('Login cancelled by the user.');
          break;
        case FacebookLoginStatus.error:
          _showMessage('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
    }

    // TODO: implement build
    return Container(
      child: InkWell(
        // onTap: ()=>sendNotification(title: "line",body:"coming soon"),
        // onTap: ()=>{assetsAudioPlayer.play()},
        onTap: ()=>_login(),
        child: ClipOval(
          child: Image.asset(
            "assets/icons/facebook.png",
            height: 48,
          ),
        ),
      ),
    );
  }

}