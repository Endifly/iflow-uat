import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/components/customClass/UserSessions.dart';
import 'package:ios_d1/components/customClass/useUserSession.dart';
import 'package:ios_d1/contexts/kPrefs.dart';
import 'package:ios_d1/services/SessionService.dart';
import 'package:ios_d1/views/ProfilePage/SummaryPage/ConsciousSummaryPage.dart';
import 'package:ios_d1/views/ProfilePage/SummaryPage/RelaxSummaryPage.dart';
import 'package:ios_d1/views/Template/NavLayout.dart';
import '/components/ButtonNavigationBar.dart';
import '/components/customWidgets/Typography.dart';
import '/views/ProfilePage/ResultContainer.dart';
import '/views/Template/tLayout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  String? username = "";
  String? avatarURL = "";
  SessionServices sessionServices = SessionServices();

  // final useUserSession = UseUserSession();
  UserSessions userSessions = UserSessions();


  void _setup() async {
    await sessionServices.initial();
    await userSessions.sync();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(kPrefs.username);
      avatarURL = prefs.getString(kPrefs.avatarURL);

    });
  }

  Future onSync() async{
    if (userSessions.sessions != null) {
      var firstSession = userSessions.sessions![0];
      // await sessionServices.uploadOneSession(firstSession);
      await sessionServices.session('1');
      // await sessionServices.sessions();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _setup();
    super.initState();
  }

  DecorationImage getAvatar() {
    print(avatarURL);
    var defaultProfile = DecorationImage(image : AssetImage("assets/images/person_2.png"),);
    if (avatarURL == null) return defaultProfile;
    if (avatarURL == "") return defaultProfile;
    if (avatarURL!.startsWith('http')) return DecorationImage(image: NetworkImage(avatarURL!,),fit: BoxFit.fill);
    return DecorationImage(image : AssetImage("assets/images/person_2.png"),);
  }


  // List<Widget> SessionHistory(UserSessions? us)  {
  //   List<Widget> widgets = [];
  //   if (us == null) return widgets;
  //   us.sessions.forEach((e) {
  //     widgets.add(ResultContainer(sessionData: e,));
  //     widgets.add(SizedBox(height: 16,));
  //   });
  //   return widgets;
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    void viewRelax(List<int>? relaxes,int? duraiton) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new RelaxSummaryPage(
              relaxIndexs: relaxes,
              isSessionComplete: false,
              duration: duraiton,
            )),
      );
    }

    void viewWandering(List<int>? relaxes,int? duraiton) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new ConsciousSummaryPage(
              relaxIndexs: relaxes,
              isSessionComplete: false,
              duration: duraiton,
            )),
      );
    }

    void viewSession(String type,List<int>? relaxes,int? duraiton) {
      if (type == "relax") viewRelax(relaxes,duraiton);
      if (type == "wandering") viewWandering(relaxes,duraiton);

    }

    List<Widget> SessionHistory(UserSessions? us)  {
      List<Widget> widgets = [];
      print("### us ${us}");
      if (us == null) return widgets;
      print("### us2 ${us.sessions?.length}");
      us.sessions?.forEach((e) {
        widgets.add(ResultContainer(sessionData: e,onpress: ()=>viewSession(e.type,e.rawRelax,e.duration),));
        widgets.add(SizedBox(height: 16,));
      });
      return widgets;
    }

    return NavLayout(
          useSafeArea: false,
          child: Container(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
              children: [
                ProfileImage(Avatar: getAvatar(),),
                SizedBox(height: 16,),
                CTypo(text: "ชื่อ ${username}",variant: "body1",color: "secondary",),
                SizedBox(height: 32,),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 8),
                      child: CTypo(text: "ดูข้อมูลย้อนหลัง",variant: "body1",),
                    ),
                    Container(
                      child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.sync),
                        onPressed: onSync,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16,),
                // ResultContainer(onpress: ()=>Navigator.pushNamed(context, '/history'),),
                Column(
                  children: SessionHistory(userSessions),
                )
                // FutureBuilder(
                //     future: useUserSession.getUserSession(),
                //     builder: (context,AsyncSnapshot<UserSessions?> snapshot) {
                //       if (snapshot.hasData) {
                //         return Column(children: SessionHistory(snapshot.data),);
                //       }
                //       return Container(
                //         child: CTypo(
                //           text: 'กรุณาเริ่ม session เพื่อบันทึกข้อมูล',
                //           color: 'secondary',
                //           variant: 'body2',
                //           textAlign: TextAlign.start,
                //         ),
                //       );
                //     }
                // ),
              ],
            ),
          ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final DecorationImage? Avatar;
  ProfileImage({this.Avatar});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Stack(
        children: [
          FractionalTranslation(
              translation: Offset(0,-0.45),
              child: Transform.scale(
                scale: 2,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.7,
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(255, 194, 174, 1),
                        Color.fromRGBO(255, 171, 143, 1),
                        Color.fromRGBO(255, 192, 232, 1),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              )
          ),
          FractionalTranslation(
              translation: Offset(0,0.15),
              child: Transform.scale(
                scale: 0.75,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.7,
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color : Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              )
          ),
          FractionalTranslation(
              translation: Offset(0,0.15),
              child: Transform.scale(
                scale: 0.7,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.7,
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    image: Avatar,
                    color : Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              )
          ),
          Positioned(
            left: 0,
            top: 40,
            child: Container(
              child: SizedBox(
                child: IconButton(
                  onPressed: ()=>Navigator.pushNamed(context, "/setting"),
                  icon: Image.asset("assets/icons/setting1.png",fit: BoxFit.fill,),
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}