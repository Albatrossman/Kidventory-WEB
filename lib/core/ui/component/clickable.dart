import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double borderRadius;

  const Clickable({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 8
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
    );
  }
}
