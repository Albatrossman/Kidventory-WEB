import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

mixin NavigationMixin<T extends StatefulWidget> on State<T> {
  void push(Widget page) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  void pop() {
    Navigator.of(context).pop();
  }

  void popAndPush(Widget page) {
    Navigator.of(context).popAndPushNamed(page.toString());
  }

  void replace(Widget page) {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  void pushAndClear(Widget page, { bool fullscreenDialog = false }) {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
          fullscreenDialog: fullscreenDialog,
          builder: (context) => page),
          (_) => false,
    );
  }

  void pushSheet(Widget page) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: page,
        );
      },
    );
  }
}