import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '/components/customWidgets/Textfield.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/Typography.dart' as Typo;
import '/contexts/Constant.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/dart.'
// import 'package:iflow/components/OrangeButton.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
// @override
// Widget build(BuildContext context) {
//   // TODO: implement build
//   return Scaffold();
// }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String username = "";
  String password = "";
  String errorMessage = "";
  String accessToken = "";

  void toHome() {
    Navigator.pushNamed(context, '/home');
  }

  void handleChangeUsername(String val) {
    // print("parent : ${val}");
    setState(() {
      username = val;
      errorMessage = "";
    });
  }

  void handleChangePassword(String val) {
    // print("parent : ${val}");
    setState(() {
      password = val;
      errorMessage = "";
    });
  }

  SpinKitFadingCircle spinkit = SpinKitFadingCircle(
    color: Colors.white,
    size: 50.0,
  );

  void _setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("pref : ${prefs.getString('usernames')}");
    if (prefs.getString('username') != null) {
      toHome();
    }
  }

  void _setUser({required String username,user_id, role}) async {
    print("setting ...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('user_id', user_id);
    await prefs.setString('role', role);
    print("SharedPreferences ${username}");
  }

  // void _getUser() {
  //   const res = http.
  // }

  Future<http.Response> login(String username,String password, String URI) {
    return http.post(
      // Uri.https('dbku23tsqd.execute-api.ap-southeast-1.amazonaws.com', 'default/iflow-d1'),
      Uri.http(URI, 'auth/iflow'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        // 'path' : '/auth/iflow',
        'username': username,
        'password': password,
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _setup();
    super.initState();
    // setState(() {
    //   username='aqover';
    //   password='abcDEF098';
    // });
  }

  void onLoginSuccess(String token) async {
    print("setting ...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString(kPrefs.userID, username);
    await prefs.setString('accessToken', token);
    await prefs.setDouble('threshold', 60.0);
    print("SharedPreferences ${username}");
    setState(() {
      accessToken = token;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    void onSubmit() async{
      print("username : ${username}, password : ${password}, URI : ${MyConstants.of(context)!.REST_URI}");
      setState(() {
        loading = true;
      });
      var response = await login(username, password, MyConstants.of(context)!.REST_URI);
      setState(() {
        loading = false;
      });
      var token = response.body;
      if (token == "") {
        print("fail");
      }
      else {
        print("ye");
        print("accessToken : ${token}");
        onLoginSuccess(token);
        toHome();
      }
      // var body = jsonDecode(response.body);
      // var res = body['result'];
      // switch(body['result']['__typename']) {
      //   case "loginOutput" : {
      //     await _setUser(username: res['username'],role: res['role'],user_id: res['user_id']);
      //     toHome();
      //     break;
      //   }
      //   case "error" : {
      //     setState(() {
      //       errorMessage = body['result']['message'];
      //     });
      //     break;
      //   }
      //   default :
      //     errorMessage = "Something went wrong";
      // }

    }

    return Scaffold(
            // backgroundColor: Color.fromRGBO(252, 254, 255, 1),
            // backgroundColor: Color(0XFFEFF3F6),
            // backgroundColor: Color(0xFFEFEEEE),
          // backgroundColor: Color.fromRGBO(233, 234, 238, 1),
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                // color: Colors.red,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end : Alignment.bottomCenter,
                  colors: [Colors.white,Color.fromRGBO(233, 234, 238, 1)]
                )
              ),
              padding: EdgeInsets.all(72),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "เข้าสู่ระบบ",
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ด้วย I Flow Account",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                  Container(height: 32),
                  OrangeTextfield(title: "Username",callback: handleChangeUsername,),
                  Container(height: 16),
                  OrangeTextfield(title: "Password",callback: handleChangePassword,password: true,),
                  SizedBox(height: 16,),
                  Typo.CTypo(text: errorMessage,variant: "subtitle1",color: "error",),
                  Container(
                    height: 40,
                  ),

                  Container(height: 32),
                  // onTap: () => {Navigator.pushNamed(context, '/signup')},
                  loading ? Container(child: spinkit,margin: EdgeInsets.fromLTRB(0, 0, 0, 16),) : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          child: OrangeButton(title: "ถัดไป",onPress: onSubmit,),
                        )
                    ],
                  ),
                  Container(
                    height: 16,
                  ),
                  Text(
                    "ลืมรหัสผ่าน",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black38),
                  )
                ],
              ),
            ));
  }
}

// extension ColorUtils on Color {
//   Color mix(Color another, double amount) {
//     return Color.lerp(this, another, amount);
//   }
// }
