import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin MessageMixin<T extends StatefulWidget> on State<T> {
  void snackbar(String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> dialog(Widget title, Widget child, List<Widget> actions) async {
    return showDialog<void>(
      context: context, // This context is from the State<T> class.
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: child,
          actions: actions,
        );
      },
    );
  }
}
