import 'package:flutter/material.dart';

mixin MessageMixin<T extends StatefulWidget> on State<T> {
  void snackbar(String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
