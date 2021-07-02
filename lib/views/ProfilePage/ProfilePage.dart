import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  void _setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      avatarURL = prefs.getString('avatarURL');

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _setup();
    super.initState();
  }

  DecorationImage getAvatar() {
    print(avatarURL);
    if (avatarURL != "") return DecorationImage(image: NetworkImage(avatarURL!));
    // return Image.asset("assets/images/person_2.png");
    return DecorationImage(
      image : AssetImage("assets/images/person_2.png"),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 8),
                  child: CTypo(text: "ดูข้อมูลย้อนหลัง",variant: "body1",),
                ),
                SizedBox(height: 16,),
                ResultContainer(onpress: ()=>Navigator.pushNamed(context, '/history'),),
                SizedBox(height: 16,),
                ResultContainer(),
                SizedBox(height: 16,),
                ResultContainer(),
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