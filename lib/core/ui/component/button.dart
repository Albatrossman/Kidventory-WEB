import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class AppButton extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final Widget child;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const AppButton({
    super.key,
    required this.controller,
    required this.child,
    required this.onPressed,
    this.width = kIsWeb ? 350 : 600,
    this.height = kIsWeb ? 56 : 40,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: controller,
      onPressed: onPressed,
      elevation: 0,
      width: width,
      height: height,
      loaderSize: 24,
      color: Theme.of(context).colorScheme.primary,
      child: child,
    );
  }
}