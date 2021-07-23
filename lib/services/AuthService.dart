import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ios_d1/Provider/ProfileProvider.dart';
import 'package:ios_d1/components/DTO/iflowRegisDTO.dart';
import 'package:ios_d1/components/customClass/ProfileQuery.dart';
import 'package:ios_d1/components/customClass/UseProfile.dart';
import 'package:ios_d1/contexts/kURI.dart';

class AuthService {
  UseProfile profile = UseProfile();

  AuthService();

  Future<http.Response> getCurrentUserFromToken() async {
    var accessToken = await profile.getAccessToken();

    return http.get(
      Uri.http(kURI.BACKEND, '/user/me'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${accessToken}'
      },
    );
  }

  Future<ProfileQuery> queryMe() async{
    var res = await getCurrentUserFromToken();
    print("queyme response code ${res.statusCode}");
    if (res.statusCode == 200) {
      var body = res.body;
      print(body);
      ProfileQuery profile = ProfileQuery.fromJson(jsonDecode(body));
      return profile;
    }
    if (res.statusCode == 401) {
      await profile.clearProfile();
      return ProfileQuery.invalid();
    }
    return ProfileQuery.invalid();
  }

  Future logout(context) async {
    await profile.clearProfile();
    Navigator.pushNamedAndRemoveUntil(context, "/select-auth", (route) => false);
  }

  static Future<void> initUser(ProfileQuery profileQuery,ProfileProvider profileProvider) async {
    UseProfile profile = UseProfile();
    if (profileQuery == null) return ;

    await UseProfile.initProfile(profileQuery);

    profileProvider.setToken(profileQuery.accessToken);
    profileProvider.setThreshold(60.0);

    var userID = await profile.getUserID();
    print("SharedPreferences ${userID}");

    // toHome();
  }

  static Future<http.Response> createIflowUser(iflowRegisDTO regisParams) async {
    return http.put(
      Uri.http(kURI.BACKEND, '/auth/iflow'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "username": regisParams.username,
        "password": regisParams.password,
        "email": regisParams.email,
        "phone": regisParams.phoneNo
      }),
    );
  }

  static Future<http.Response> silentLogin({token:String}) async {
    // var accessToken = await profile.getAccessToken();

    return http.get(
      Uri.http(kURI.BACKEND, '/user/me'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${token}'
      },
    );
  }

  static Future<http.Response> login({username:String,password:String}) async {
    // var accessToken = await profile.getAccessToken();

    return http.post(
      Uri.http(kURI.BACKEND, '/auth/iflow'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
      }),
    );
  }

  static iflowRegis(iflowRegisDTO regisParams) async {
    var res = await createIflowUser(regisParams);
    print(res.body);
    // print(res.statusCode);
    // if (res.statusCode == 201) {
    //   var loginRes = await login(username: regisParams.username,password: regisParams.password);
    //   print(loginRes.body);
    // }
  }


}