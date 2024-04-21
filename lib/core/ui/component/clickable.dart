import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const Clickable({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: child,
    );
  }
}