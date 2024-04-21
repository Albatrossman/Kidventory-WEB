import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/model/time_mode.dart';

class Event {
  final String? id;
  final String? imageUrl;
  final String? imageFile;
  final String name;
  final String? description;
  final Repeat repeat;
  final TimeMode timeMode;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Location? location;
  final OnlineLocation? onlineLocation;
  final Color color;
  final Session? session;
  final InviteLink inviteLink;

  Event({
    this.id,
    this.imageUrl,
    this.imageFile,
    required this.name,
    this.description,
    required this.repeat,
    required this.timeMode,
    required this.startTime,
    required this.endTime,
    this.location,
    this.onlineLocation,
    required this.color,
    this.session,
    required this.inviteLink,
  });
}

class Repeat {
  final int period;
  final PeriodUnit unit;
  final List<String>? daysOfWeek;
  final String? monthDay;
  final int? monthDate;
  final DateTime startDateTime;
  final EndsOnMode endsOnMode;
  final DateTime endDate;
  final int maxOccurrence;

  bool get isNever => (endsOnMode == EndsOnMode.date && startDateTime == endDate) ||
      (endsOnMode == EndsOnMode.maxOccurrence && maxOccurrence == 1);

  Repeat({
    required this.period,
    required this.unit,
    this.daysOfWeek,
    this.monthDay,
    this.monthDate,
    required this.startDateTime,
    required this.endsOnMode,
    required this.endDate,
    required this.maxOccurrence,
  });
}

enum PeriodUnit { day, week, monthDay, monthDate }
enum EndsOnMode { date, maxOccurrence }

class Location {
  final String id;
  final String fullText;
  final String primaryText;
  final String secondaryText;

  Location({
    required this.id,
    required this.fullText,
    required this.primaryText,
    required this.secondaryText,
  });
}

class OnlineLocation {
  final Platform platform;
  final String sessionLink;
  final String? meetingId;
  final String? password;
  final String? comment;
  final String? phone;
  final String? pin;

  OnlineLocation({
    required this.platform,
    required this.sessionLink,
    this.meetingId,
    this.password,
    this.comment,
    this.phone,
    this.pin,
  });
}

enum Platform { skype, googleMeet, zoom }

class Session {

}

class InviteLink {
  final String? eventId;
  final DateTime? expiryDate;
  final String? id;
  final bool isActive;
  final bool isPrivate;
  final String? referenceId;

  InviteLink({
    this.eventId,
    this.expiryDate,
    this.id,
    required this.isActive,
    required this.isPrivate,
    this.referenceId,
  });
}
