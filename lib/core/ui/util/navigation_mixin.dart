import 'package:flutter/cupertino.dart';

mixin NavigationMixin<T extends StatefulWidget> on State<T> {
  void push(Widget page) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  void pop() {
    Navigator.of(context).pop();
  }

  void replace(Widget page) {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  void pushAndClear(Widget page, { bool fullscreenDialog = false }) {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(fullscreenDialog: fullscreenDialog, builder: (context) => page),
          (_) => false,
    );
  }
}