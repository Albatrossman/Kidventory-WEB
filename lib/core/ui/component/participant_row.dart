import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParticipantRow extends StatelessWidget {
  final String? avatarUrl;
  final String name;
  final VoidCallback onClick;
  final Widget? trailing;

  const ParticipantRow({
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
                backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  CupertinoIcons.person,
                  size: 24,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(width: 8),
              Text(name)
            ],
          ),
        ),
      ),
    );
  }
}