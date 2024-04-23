import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';

class SheetHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget title;
  final Widget trailing;

  @override
  Size get preferredSize {
    return const Size.fromHeight(48.0);
  }

  const SheetHeader({
    super.key,
    this.leading,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title,
      leading: leading ??
          Clickable(
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(CupertinoIcons.xmark_circle),
          ),
      actions: [
        trailing,
        const SizedBox(width: 16),
        ],
    );
  }
}
