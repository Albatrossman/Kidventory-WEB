import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingMemberRow extends StatelessWidget {
  final String? avatarUrl;
  final String name;
  final VoidCallback onClick;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final Widget? trailing;

  const PendingMemberRow({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.onClick,
    required this.onAccept,
    required this.onDecline,
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
              SizedBox(
                height: 28,
                child: OutlinedButton(
                  onPressed: () {
                    onDecline();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: CupertinoColors.systemRed, width: 1),
                  ),
                  child: Text(
                    "Decline",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: CupertinoColors.systemRed, fontSize: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 28,
                child: OutlinedButton(
                  onPressed: () {
                    onAccept();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: CupertinoColors.systemGreen, width: 1),
                  ),
                  child: Text(
                    "Accept",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: CupertinoColors.systemGreen, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
