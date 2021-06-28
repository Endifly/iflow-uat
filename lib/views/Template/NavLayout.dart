import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/ButtonNavigationBar.dart';

class NavLayout extends StatefulWidget {
  final Widget child;
  final EdgeInsets? customEdge;
  final bool useSafeArea ;
  final BoxDecoration? boxDecoration;

  NavLayout({required this.child,this.customEdge, required this.useSafeArea,this.boxDecoration});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NavLayoutState();
  }

}

class _NavLayoutState extends State<NavLayout> {

  EdgeInsets getEdge() {
    if (widget.customEdge == null) return EdgeInsets.fromLTRB(0, 0, 0, 0);
    else return widget.customEdge!;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (!widget.useSafeArea) return Scaffold(
      body: Container(
        decoration: widget.boxDecoration,
        child: Column(
          children: [
            Container(
              padding: getEdge(),
              height: MediaQuery.of(context).size.height-80,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [widget.child],
              ),
            ),
            ButtonNavigationBar(),
          ],
        ),
      ),
    );

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