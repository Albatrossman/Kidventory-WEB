import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const Clickable({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: child,
    );
  }
}