import 'package:flutter/material.dart';

class EventOption extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final String label;
  final VoidCallback onTap;

  const EventOption({
    super.key,
    this.leading,
    this.trailing,
    required this.label,
    required this.onTap,
  });

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
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              if (trailing != null) ... [
                const SizedBox(width: 8),
                trailing!
              ],
            ],
          ),
        ),
      ),
    );
  }
}
