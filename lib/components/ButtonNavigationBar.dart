import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_d1/contexts/kColors.dart';

class NavButton extends StatelessWidget {
  final Widget icon;
  final String path;
  final String to;

  NavButton({required this.icon,required this.path,required this.to});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget buttonWrapper(String path,String to) {
      var currentRoute = ModalRoute.of(context)?.settings.name;

      // print("### ${currentRoute} ${path}");

      if (currentRoute == path) return Container(
          child: Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              // color: kColors.gold[500],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.amberAccent.withOpacity(0.4),Colors.amber],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: Offset(3,3),
                )
              ]
            ),
            child: IconButton(
              // icon: Image.asset("assets/icons/b_profile_deactivate.png"),
                icon: icon,
                color: Colors.white,
                onPressed: ()=>{if (currentRoute != to) Navigator.pushReplacementNamed(context, to) }),
          )
      );
      return IconButton(
        // icon: Image.asset("assets/icons/b_profile_deactivate.png"),
          icon: icon,
          color: kColors.black[200],
          onPressed: ()=>{Navigator.pushReplacementNamed(context, to)});
    }

    return buttonWrapper(path,to);
  }
}

class ButtonNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    // print(ModalRoute.of(context).settings.name)

    Widget buttonWrapper(Widget child,String path) {
      var currentRoute = ModalRoute.of(context)?.settings.name;
      if (currentRoute == path) return Container(
        child: Container(
          decoration: BoxDecoration(
            color: kColors.gold[400],
            shape: BoxShape.circle,
          ),
          child: child,
        )
      );
      return child;
    }

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            padding: EdgeInsets.all(16),
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 24.0,
                      spreadRadius: 6.0),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavButton(
                  icon: Image.asset("assets/icons/b_iflow_deactivate.png"),
                  to:'/aboutus',
                  path: '/aboutus',
                ),
                NavButton(
                  path: '/home',
                  to: '/home',
                  icon: FaIcon(FontAwesomeIcons.home),
                ),
                NavButton(
                  path: '/profile',
                  to: '/profile',
                  icon: FaIcon(FontAwesomeIcons.userAlt),
                ),
              ],
            ),
          ),
        ));
  }

}