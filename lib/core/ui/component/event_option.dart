import 'package:flutter/material.dart';

class EventOption extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget label;
  final VoidCallback onTap;

  const EventOption._({
    super.key,
    this.leading,
    this.trailing,
    required this.label,
    required this.onTap,
  });

  factory EventOption.withText({
    Key? key,
    Widget? leading,
    Widget? trailing,
    required String label,
    required VoidCallback onTap,
  }) =>
      EventOption._(
        key: key,
        leading: leading,
        trailing: trailing,
        label: Text(label),
        onTap: onTap,
      );

  factory EventOption.withWidget({
    Key? key,
    Widget? leading,
    Widget? trailing,
    required Widget label,
    required VoidCallback onTap,
  }) =>
      EventOption._(
        key: key,
        leading: leading,
        trailing: trailing,
        label: label,
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              if (leading != null) leading! else const SizedBox(width: 20),
              const SizedBox(width: 8),
              Expanded(
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.labelMedium ?? const TextStyle(),
                  child: label,
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ],
          ),
        ),
      ),
    );
  }
}
