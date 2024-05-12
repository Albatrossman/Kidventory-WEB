import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';
import 'package:kidventory_flutter/core/ui/util/extension/string_extension.dart';

class MultiSelectCard extends StatelessWidget {
  final String name;
  final VoidCallback onClick;
  final bool isSelected;

  const MultiSelectCard({
    super.key,
    required this.name,
    required this.onClick,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      borderRadius: 16,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        color:
            isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
        elevation: 0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Expanded(
                child: Text(name.capitalize()),
              ),
            ),
            const Spacer(),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: isSelected
                  ? Icon(CupertinoIcons.check_mark_circled,
                      color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
      onPressed: () {
        onClick();
      },
    );
  }
}
