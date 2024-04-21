import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';

class SheetHeader extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget trailing;

  const SheetHeader({
    super.key,
    this.leading,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  leading ?? Clickable(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(CupertinoIcons.xmark_circle),
                  ),
                  title,
                  trailing,
                ],
              ),
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
