import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';

class JoinMemberCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final VoidCallback onClick;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final ShapeBorder? shape;
  final bool isSelected;

  const JoinMemberCard({
    super.key,
    required this.name,
    required this.onClick,
    this.imageUrl,
    this.onLongPress,
    this.onDoubleTap,
    this.shape,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: onClick,
      borderRadius: 16,
      child: Card(
        shape: shape ??
            RoundedRectangleBorder(
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
              child: _buildAvatar(context),
            ),
            Expanded(
              child: _builtTitle(context),
            ),
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
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.outline
                : Theme.of(context).colorScheme.outlineVariant,
            width: 1.0),
        borderRadius: BorderRadius.circular(96.0),
      ),
      child: ClipOval(
        child: CircleAvatar(
          radius: 96.0,
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.primaryContainer,
          child: SizedBox.fromSize(
            child: imageUrl == "plus"
                ? Icon(
                    CupertinoIcons.plus,
                    size: 20,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  )
                : CachedNetworkImage(
                    imageUrl: imageUrl ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Icon(
                      CupertinoIcons.person,
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      CupertinoIcons.person,
                      size: 20,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _builtTitle(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.bodyMedium,
      overflow: TextOverflow.ellipsis,
    );
  }
}
