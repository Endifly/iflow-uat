import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ios_d1/components/customWidgets/LineLogin.dart';
import 'package:ios_d1/contexts/kColors.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import '/Provider/ProfileProvider.dart';
import '/components/customWidgets/OrangeButton.dart';
import '/components/customWidgets/WhiteButton.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
import '/contexts/Constant.dart';
import '/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:iflow/components/neu_calculator_button.dart';
// import 'package:iflow/components/neumorphic_theme.dart';

// import 'package:flutter/dart.'
// import 'package:iflow/components/OrangeButton.dart';

class SelectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelectPageState();
  }
// @override
// Widget build(BuildContext context) {
//   // TODO: implement build
//   return Scaffold();
// }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

class _SelectPageState extends State<SelectPage> {
  final _formKey = GlobalKey<FormState>();
  // var assetsAudioPlayer = AssetsAudioPlayer();
  // final assetsAudioPlayer = Ass

  String _message = 'Log in/out by pressing the buttons below.';
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  // String message;
  bool loading = false;
  String channelId = "1000";
  String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
  String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";

  // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  sendNotification({title:String,body:String}) async {
    print("### enter");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('10000',
        'FLUTTER_NOTIFICATION_CHANNEL', 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(android:androidPlatformChannelSpecifics,iOS:iOSPlatformChannelSpecifics  );

    print("### pushing");
    await flutterLocalNotificationsPlugin.show(111, title,
        body, platformChannelSpecifics,
        payload: 'I just haven\'t Met You Yet');
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // assetsAudioPlayer.open(Audio("assets/sounds/gong.mp3"));
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("message ${message}");
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   print("andriod noti : ${notification.title} ${notification.body}");
    //   sendNotification(title: notification.title,body: notification.body);
    // });
    // firebaseMessaging.getToken().then((value) => print("token :${value}:"));
    //
    // message = "No message.";

    // var initializationSettingsAndroid =  AndroidInitializationSettings('iflow');
    //
    // var initializationSettingsIOS = IOSInitializationSettings(
    //     onDidReceiveLocalNotification: (id, title, body, payload) {
    //       print("onDidReceiveLocalNotification called.");
    //     });
    // var initializationSettings = InitializationSettings(android: initializationSettingsAndroid,iOS: initializationSettingsIOS);
    //
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: (payload) {
    //       // when user tap on notification.
    //       print("onSelectNotification called.");
    //       setState(() {
    //         message = payload;
    //       });
    //     });
    print("### initialize");
  }

  Future<void> _setUser({required String username,user_id, role}) async {
    print("setting ...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('user_id', user_id);
    await prefs.setString('role', role);
    await prefs.setDouble('threshold', 60.0);
    print("SharedPreferences ${username}");
  }

  void _setToken({required String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fbtoken', token);
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    print(message);
    setState(() {
      _message = message;
    });
  }

  Future<http.Response> login(String username,String password, String URI) {
    return http.post(
      Uri.https('dbku23tsqd.execute-api.ap-southeast-1.amazonaws.com', 'default/iflow-d1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'path' : '/loginfacebook',
        'username': username,
        'password': password,
      }),
    );
  }

  SpinKitFadingCircle spinkit = SpinKitFadingCircle(
    color: kColors.gold[500]!,
    size: 50.0,
  );

  void toHome() {
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    Future<http.Response> testerID() {
      return http.post(
        // Uri.https('dbku23tsqd.execute-api.ap-southeast-1.amazonaws.com', 'default/iflow-d1'),
        Uri.http(MyConstants.of(context)!.REST_URI, 'auth/iflow'),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          // 'path' : '/auth/iflow',
          'username': 'aqover',
          'password': 'abcDEF098',
        }),
      );
    }

    // void onTesterLogin() async{
    //   // print("username : ${username}, password : ${password}, URI : ${MyConstants.of(context)!.REST_URI}");
    //   setState(() {
    //     loading = true;
    //   });
    //   var response = await testerID();
    //   setState(() {
    //     loading = false;
    //   });
    //   var token = response.body;
    //   if (token == "") {
    //     print("fail");
    //   }
    //   else {
    //     print("ye");
    //     print("accessToken : ${token}");
    //     // onLoginSuccess(token);
    //     toHome();
    //   }
    // }

    // void _setUser({required String username,user_id, role}) async {
    //   print("setting ...");
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('username', username);
    //   await prefs.setString('user_id', user_id);
    //   await prefs.setString('role', role);
    //   print("SharedPreferences ${username}");
    // }

    Future<void> onLoginSuccess(String token,String username) async {
      print("setting ...");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString(kPrefs.userID, username);
      await prefs.setString('accessToken', token);
      await prefs.setDouble('threshold', 60.0);
      print("SharedPreferences ${username}");
      setState(() {
        // accessToken = token;
        loading = false;
      });
    }

    void onTesterLogin() async {
      // print("username : ${username}, password : ${password}, URI : ${MyConstants.of(context)!.REST_URI}");
      setState(() {
        loading = true;
      });
      var response = await testerID();
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
        onLoginSuccess(token,'aqover');
        toHome();
      }
    }

    void onSubmit() async{
      print("submit");
      var response = await login("123", "123", MyConstants.of(context)!.REST_URI);
      var body = jsonDecode(response.body);
      var res = body['result'];
      print(res);
      switch(body['result']['__typename']) {
        case "loginOutput" : {
          await _setUser(username: 'fb-user',role: res['role'],user_id: res['user_id']);
          toHome();
          break;
        }
        case "error" : {
          break;
        }
        default :
      }

    }

    Future<Null> _login() async {
      print("start login ...");
      final FacebookLoginResult result =
      await facebookSignIn.logIn(['email']);

      print("logged in ... ${result.status}");
      print(result.errorMessage);
      // print(result.accessToken.token);
      onSubmit();
      // print(result.status);
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
          _setToken(token: accessToken.token);
          profileProvider.setToken(accessToken.token);
          profileProvider.setThreshold(50.0);
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

    void onClickMobileNo() {
      Navigator.pushNamed(context, '/mobile-no');
    }

    void onClickSignUp() {
      Navigator.pushNamed(context, '/signup');
    }

    void onClickLogin() {
      Navigator.pushNamed(context, '/login');
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
                      OrangeButton(title:"เข้าระบบ",onPress: onClickLogin,),
                    ],
                  ),
                  Container(
                    height: 16,
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
                  Container(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // WhiteButton(title:"TESTER ID",onPress: onTesterLogin,),
                      loading ? Container(child: spinkit,margin: EdgeInsets.fromLTRB(0, 0, 0, 16),) : WhiteButton(title:"TESTER ID",onPress: onTesterLogin,),
                    ]
                  ),
                  Container(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.amber,
                            margin: EdgeInsets.all(16),
                          ),
                      ),
                      Text("หรือ"),
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.amber,
                          margin: EdgeInsets.all(16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: ()=> {_login()},
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/facebook.png",
                            height: 48,
                          ),
                        ),
                      ),
                      // Icon(
                      //   Icons.face_unlock_outlined,
                      //   color: Colors.grey,
                      //   size: 42.0,
                      //   semanticLabel: 'Text to announce in accessibility modes',
                      // ),
                      LineLogin(),
                    ],
                  ),
                  Container(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: WhiteButton(title:"mobile no",onPress: onClickMobileNo,),
                      ),
                    ],
                  ),
                  Container(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text(
                          "* กรณีไม่มีสัญญาณอินเตอร์เน็ต",
                          style: TextStyle(color: Colors.black38, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 32),
                  Row(
                    children: [
                      Expanded(
                          child: OrangeButton(title:"สมัคร",onPress: onClickSignUp,)
                      ),
                    ],
                  ),
                  Container(
                    height: 16,
                  ),
                  Text(
                    "ลืมรหัสผ่าน",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black38),
                  ),
                  // NeuCalculatorButton(
                  //   text: '+/-',
                  //   onPressed: () {},
                  // ),
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
