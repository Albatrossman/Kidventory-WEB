import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/card.dart';

class SessionCard extends StatelessWidget {
  final SessionDto session;
  final VoidCallback onClick;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final ShapeBorder? shape;

  const SessionCard({
    super.key,
    required this.session,
    required this.onClick,
    this.onLongPress,
    this.onDoubleTap,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      onLongPress: onLongPress ?? onClick,
      onDoubleTap: onDoubleTap ?? onClick,
      child: Card(
        shape: shape ??
            RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
        elevation: 0,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 56.0,
                      height: 56.0,
                      child: AppCard(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: SizedBox.fromSize(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: session.imageUrl ?? "",
                              placeholder: (context, url) => Icon(
                                  CupertinoIcons.photo,
                                  color: Theme.of(context).colorScheme.primary),
                              errorWidget: (context, url, error) => Icon(
                                CupertinoIcons.photo,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                session.startDateTime.formatDate(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Row(
                                children: [
                                  Text(
                                    DateFormat.jm().format(session.startDateTime.toLocal()),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const Text(" - "),
                                  Text(
                                    DateFormat.jm().format(session.endDateTime.toLocal()),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            session.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 12.0,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class Session {
  final String sessionId;
  final String eventId;
  final String? imageUrl;
  final String title;
  final String timeMode;
  final String color;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final List<Member> members;

  Session({
    required this.sessionId,
    required this.eventId,
    required this.imageUrl,
    required this.title,
    required this.timeMode,
    required this.color,
    required this.startDateTime,
    required this.endDateTime,
    required this.members,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionId: json['sessionId'],
      eventId: json['eventId'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      timeMode: json['timeMode'],
      color: json['color'],
      startDateTime: DateTime.parse(json['startDateTime']),
      endDateTime: DateTime.parse(json['endDateTime']),
      members:
          List<Member>.from(json['members'].map((x) => Member.fromJson(x))),
    );
  }
}

class Member {
  final String id;
  final String avatarUrl;
  final String firstName;
  final String lastName;
  final String parentId;

  Member({
    required this.id,
    required this.avatarUrl,
    required this.firstName,
    required this.lastName,
    required this.parentId,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      parentId: json['parentId'],
    );
  }
}
