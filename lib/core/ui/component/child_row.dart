import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/util/model/child_info.dart';

class ChildRow extends StatelessWidget {
  final ChildInfo info;

  const ChildRow({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1.0,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: CircleAvatar(
              radius: 96.0,
              child: SizedBox.fromSize(
                child: CachedNetworkImage(
                  imageUrl: info.image,
                  placeholder: (context, url) => const Icon(
                    CupertinoIcons.person,
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    CupertinoIcons.person,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${info.firstName} ${info.lastName}",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                info.birthday.formatDate(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Spacer(),
          Icon(
            CupertinoIcons.forward,
            color: Theme.of(context).colorScheme.outline,
          ),
        ],
      ),
    );
  }
}
