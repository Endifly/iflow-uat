// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:async';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ios_d1/Provider/HeadsetProvider.dart';
import 'package:ios_d1/components/customWidgets/HeadsetConnector.dart';
import 'package:ios_d1/views/ProfilePage/ProfilePage.dart';
import 'package:ios_d1/views/ProfilePage/SummaryPage/ConsciousGraph.dart';
import 'package:ios_d1/views/ProfilePage/SummaryPage/ConsciousSummaryPage.dart';
import 'package:ios_d1/views/ProfilePage/SummaryPage/RelaxSummaryPage.dart';
import 'package:ios_d1/views/SettingPage/AppSettingPage/AppSettingPage.dart';
import 'package:ios_d1/views/SettingPage/AppSettingPage/ThresholdSettingPage/ThresholdCustom.dart';
import 'package:ios_d1/views/SettingPage/AppSettingPage/ThresholdSettingPage/ThresholdSettingPage.dart';
import 'package:ios_d1/views/SettingPage/AppSettingPage/VibrationSetting/VibrationSettingPage.dart';
import 'package:ios_d1/views/SettingPage/AppSettingPage/VoiceSetting/VoiceSetting.dart';
import 'package:ios_d1/views/SettingPage/HelpPage/HelpPage.dart';
import 'package:ios_d1/views/SettingPage/InvitePage/InvitePage.dart';
import 'package:ios_d1/views/SettingPage/PersonalPage/PersonalPage.dart';
import 'package:ios_d1/views/SettingPage/PrivacyPage/Privacy.dart';
import 'package:ios_d1/views/SettingPage/SendCommentPage/SendCommentPage.dart';
import 'package:ios_d1/views/SettingPage/SettingPage.dart';
import 'package:ios_d1/views/StartPage/StartConscious.dart';
import 'package:ios_d1/views/StartPage/StartPage.dart';
import '/Provider/ProfileProvider.dart';
import '/contexts/Constant.dart';
// import 'package:iflow/views/AboutUsPage/AboutUsPage.dart';
// import 'package:iflow/views/Connecting/demo1.dart';
// import 'package:iflow/views/History/HistoryPage.dart';
import '/views/IntroducePage/IntroducePage.dart';
// import '/views/ProfilePage/SummaryPage/ConsciousGraph.dart';

// import '/views/ProfilePage/SummaryPage/ConsciousSummaryPage.dart';
import '/views/ActionPage/ConsciousPage/ConsciousPage.dart';
import '/views/ActionPage/RelaxPage/RelaxPage.dart';
import '/views/AuthPage/LoginPage.dart';
import '/views/AuthPage/MobileNoPage.dart';
import '/views/AuthPage/PolicyPage.dart';
import '/views/AuthPage/SelectPage.dart';
import '/views/AuthPage/SignUpPage.dart';
import '/views/HomePage/HomePage.dart';
import '/views/IntroPage/IntroPage.dart';
// import '/views/ProfilePage/SummaryPage/RelaxSummaryPage.dart';
// import '/views/SettingPage/AppSettingPage/AppSettingPage.dart';
// import '/views/SettingPage/AppSettingPage/ThresholdSettingPage/ThresholdSettingPage.dart';
// import '/views/SettingPage/AppSettingPage/VibrationSetting/VibrationSettingPage.dart';
// import '/views/SettingPage/AppSettingPage/VoiceSetting/VoiceSetting.dart';
// import '/views/SettingPage/HelpPage/HelpPage.dart';
// import '/views/SettingPage/InvitePage/InvitePage.dart';
// import '/views/SettingPage/PersonalPage/PersonalPage.dart';
// import '/views/SettingPage/PrivacyPage/Privacy.dart';
// import '/views/SettingPage/SendCommentPage/SendCommentPage.dart';
// import '/views/SettingPage/SettingPage.dart';
import '/views/StartPage/RelaxIntroduce/RelaxIntroduce.dart';
import '/views/StartPage/WanderingIntroduce/WanderingIntroduce.dart';
import 'package:provider/provider.dart';
// import 'views/SettingPage/AppSettingPage/ThresholdSettingPage/ThresholdCustom.dart';
// import '/views/StartPage/StartConscious.dart';
// import 'package:iflow/views/StartPage/StartPage.dart';
// import 'package:iflow/views/ProfilePage/ProfilePage.dart';
// import 'components/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const String LINE_CHANNEL_ID = "1655689195";

void main() async {
  // SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  LineSDK.instance.setup("${LINE_CHANNEL_ID}").then((_) {
    print("LineSDK Prepared");
    });
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      MyConstants(
    key: UniqueKey(),
    child:  EasyLocalization(
      supportedLocales: [Locale('en'), Locale('th')],
      path: 'assets/lang',
      fallbackLocale: Locale('th'),
      child: MyApp(),
    ),
  )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ProfileProvider(threshold: 50.0, accessToken: "")
        ),
        ChangeNotifierProvider(
            create: (_) => HeadsetProvider()
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          highlightColor: Color(0xffffc600),
          fontFamily: 'Prompt',
        ),
        home: FutureBuilder(
          // future: FlutterBluetoothSerial.instance.requestEnable(),
          // future: Firebase.initializeApp(),
          builder: (context, future) {
            if (future.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Container(
                  height: double.infinity,
                  child: Center(
                    child: Icon(
                      Icons.bluetooth_disabled,
                      size: 200.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              );
            } else if (future.connectionState == ConnectionState.done) {
              // return MyHomePage(title: 'Flutter Demo Home Page');
              return IntroPage();
            } else {
              return IntroPage();
            }
          },
          // child: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
        title: "iAware",
        routes: {
          '/introduce': (context) => IntroducePage(),

          '/select-auth': (context) => SelectPage(),
          // '/select-auth' : (context)=>ConsciousPage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/home': (context) => HomePage(),
          // '/aboutus': (context) => AboutUsPage(),

          '/start': (context) => StartPage(),
          '/relax/introduce': (context) => RelaxIntroduce(),
          '/start-conscious': (context) => StartConsciousPage(),
          '/relax': (context) => RelaxPage(),
          '/conscious': (context) => ConsciousPage(),
          '/wandering/introduce': (context) => WanderingIntroduce(),
          '/profile': (context) => ProfilePage(),
          '/relax-summary': (context) => RelaxSummaryPage(),
          '/conscious-summary': (context) => ConsciousSummaryPage(),
          '/conscious-summary-graph': (context) => ConsciousGraphPage(),

          '/policy': (context) => PolicyPage(),
          '/mobile-no': (context) => MobileNoPage(),
          // '/history': (context) => HistoryPage(),
          // '/demo1': (context) => Demo1(),

          '/setting': (context) => SettingPage(),
          '/setting/personal': (context) => PersonalInfomationPage(),
          '/setting/invite': (context) => InvitePage(),
          '/setting/privacy': (context) => PrivacyPage(),
          '/setting/app': (context) => AppSettingPage(),
          '/setting/app/voice': (context) => VoiceSettingPage(),
          '/setting/app/vibrate': (context) => VibrationSettingPage(),
          '/setting/app/threshold': (context) => ThresholdSettingPage(),
          '/setting/app/threshold/custom': (context) => ThresholdCustomPage(),
          '/setting/help': (context) => HelpPage(),
          '/setting/comment': (context) => SendCommentPage(),
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Connection'),
          ),
        ));
  }
}
