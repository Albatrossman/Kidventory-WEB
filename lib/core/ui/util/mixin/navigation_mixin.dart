import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void pushAndClear(Widget page, {bool fullscreenDialog = false}) {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
          fullscreenDialog: fullscreenDialog, builder: (context) => page),
      (_) => false,
    );
  }

  void pushSheet(Widget page) {
    if (kIsWeb) {
      showCustomModalBottomSheet(
        context: context,
        barrierColor: Colors.black.withAlpha(155),
        builder: (context) {
          return Container(
            color: Theme.of(context).colorScheme.surface,
            child: page,
          );
        },
        containerWidget: (context, animation, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: ClipRRect(
                borderRadius:
                    kIsWeb ? BorderRadius.circular(16) : BorderRadius.zero,
                child: SizedBox(width: 600, child: child),
              ),
            ),
          );
        },
      );
    } else {
      showCupertinoModalBottomSheet(
        context: context,
        overlayStyle: SystemUiOverlayStyle.light,
        barrierColor: Colors.black.withAlpha(155),
        builder: (BuildContext context) {
          return SizedBox(
            width: 600,
            child: Container(
              width: 600,
              color: Theme.of(context).colorScheme.surface,
              child: page,
            ),
          );
        },
      );
    }
  }

  void pushSmallSheet(Widget page) {
    if (kIsWeb) {
      showCustomModalBottomSheet(
        context: context,
        expand: false,
        barrierColor: Colors.black.withAlpha(155),
        builder: (context) {
          return Container(
            color: Theme.of(context).colorScheme.surface,
            child: page,
          );
        },
        containerWidget: (context, animation, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: ClipRRect(
                borderRadius:
                    kIsWeb ? BorderRadius.circular(16) : BorderRadius.zero,
                child: SizedBox(width: 600, child: child),
              ),
            ),
          );
        },
      );
    } else {
      showCupertinoModalBottomSheet(
        topRadius: const Radius.circular(16),
        expand: false,
        barrierColor: Colors.black.withAlpha(125),
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
}
