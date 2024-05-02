import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SheetHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget title;
  final Widget? trailing;

  @override
  Size get preferredSize {
    return const Size.fromHeight(57.0);
  }

  const SheetHeader({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          title: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleSmall ?? const TextStyle(),
            child: title,
          ),
          leading: leading ??
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.xmark_circle),
                onPressed: () => Navigator.of(context).pop(),
              ),
          actions: [
            trailing ?? const SizedBox.shrink(),
            const SizedBox(width: 16),
          ],
        ),
        Divider(
          height: 1.0,
          color: Theme.of(context).colorScheme.outlineVariant,
        )
      ],
    );
  }
}
