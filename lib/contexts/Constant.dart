import 'package:flutter/cupertino.dart';

class MyConstants extends InheritedWidget {
  static MyConstants? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<MyConstants>();

  const MyConstants({required Widget child,required Key key}): super(key: key, child: child);

  // final String REST_URI = 'https://dbku23tsqd.execute-api.ap-southeast-1.amazonaws.com/default/iflow-d1';
  final String REST_URI = 'api.iflowtech.co';

  @override
  bool updateShouldNotify(MyConstants oldWidget) => false;
}