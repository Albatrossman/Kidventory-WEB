import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingMemberRow extends StatelessWidget {
  final String? avatarUrl;
  final String name;
  final VoidCallback onClick;
  final Widget? trailing;

  const PendingMemberRow({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.onClick,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: SizedBox.fromSize(
                    child: CachedNetworkImage(
                      imageUrl: avatarUrl ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Icon(
                        CupertinoIcons.person,
                        size: 24,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        CupertinoIcons.person,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(name),
              const Spacer(),
              CupertinoButton(
                child: const Icon(
                  CupertinoIcons.xmark_circle,
                  size: 28,
                  color: CupertinoColors.systemRed,
                ),
                onPressed: () {},
              ),
              CupertinoButton(
                child: const Icon(
                  CupertinoIcons.check_mark_circled,
                  size: 28,
                  color: CupertinoColors.activeGreen,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
