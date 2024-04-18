import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;

  const AppCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: child
    );
  }
}
