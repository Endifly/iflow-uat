import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/ButtonNavigationBar.dart';

class tLayout extends StatefulWidget {
  final Widget child;
  final EdgeInsets? customEdge;

  tLayout({required this.child,this.customEdge});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _tLayoutState();
  }

}

class _tLayoutState extends State<tLayout> {

  EdgeInsets getEdge() {
    if (widget.customEdge == null) return EdgeInsets.fromLTRB(24, 0, 24, 0);
    else return widget.customEdge!;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: getEdge(),
              height: MediaQuery.of(context).size.height-80-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom,
              child: widget.child,
            ),
            ButtonNavigationBar(),
          ],
        ),
      )
    );
  }

}