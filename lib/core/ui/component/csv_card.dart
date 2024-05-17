import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';

class CSVCard extends StatelessWidget {
  final XFile file;
  final List<Member> members;
  final void Function() onClick;
  final void Function() onRemoveClick;

  const CSVCard({
    super.key,
    required this.file,
    required this.members,
    required this.onClick,
    required this.onRemoveClick,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => onClick(),
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file.path.split('/').last,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${members.length} Participants',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Theme.of(context).colorScheme.outline),
                  )
                ],
              ),
              const Spacer(),
              CupertinoButton(
                onPressed: () => onRemoveClick(),
                child: Icon(
                  CupertinoIcons.delete,
                  size: 20,
                  color: Theme.of(context).colorScheme.error,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
