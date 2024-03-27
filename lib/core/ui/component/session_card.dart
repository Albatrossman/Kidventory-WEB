import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';

class SessionCard extends StatelessWidget {
  final Session session;
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
                    Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: const NetworkImage("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAMFBMVEXp7vG6vsG3u77s8fTCxsnn7O/f5OfFyczP09bM0dO8wMPk6ezY3eDd4uXR1tnJzdBvAX/cAAACVElEQVR4nO3b23KDIBRA0ShGU0n0//+2KmO94gWZ8Zxmr7fmwWEHJsJUHw8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwO1MHHdn+L3rIoK6eshsNJ8kTaJI07fERPOO1Nc1vgQm2oiBTWJ+d8+CqV1heplLzMRNonED+4mg7L6p591FC+133/xCRNCtd3nL9BlxWP++MOaXFdEXFjZ7r8D9l45C8y6aG0cWtP/SUGhs2d8dA/ZfGgrzYX+TVqcTNRRO9l+fS5eSYzQs85psUcuzk6igcLoHPz2J8gvzWaH/JLS+95RfOD8o1p5CU5R7l5LkfKEp0mQ1UX7hsVXqDpRrifILD/3S9CfmlUQFhQfuFu0STTyJ8gsP3PH7GVxN1FC4t2sbBy4TNRTu7LyHJbqaqKFw+/Q0ncFloo7CjRPwMnCWqKXQZ75El4nKC9dmcJaou9AXOE5UXbi+RGeJygrz8Uf+GewSn9uXuplnWDZJ7d8f24F/s6iq0LYf9olbS3Q8i5oKrRu4S9ybwaQ/aCkqtP3I28QDgeoK7TBya/aXqL5COx67PTCD2grtdOwH+pQV2r0a7YVBgZoKwwIVFQYG6ikMDVRTGByopjD8ATcKb0UhhRTe77sKs2DV7FKSjId18TUEBYVyLhUThWfILHTDqmI85/2RWWjcE/bhP6OD7maT3h20MHsA47JC3PsW0wcwLhv9t0OOPOIkCn21y2bXXwlyylxiYMPk1SuCSmpfK8bNQvIrpAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADwNX4BCbAju9/X67UAAAAASUVORK5CYII="),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) => Icons.error,
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
                                    DateFormat.jm().format(session.startDateTime),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const Text(" - "),
                                  Text(
                                    DateFormat.jm().format(session.endDateTime),
                                    style: Theme.of(context).textTheme.bodySmall,
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
  final String title;
  final String timeMode;
  final String color;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final List<Member> members;

  Session({
    required this.sessionId,
    required this.eventId,
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
