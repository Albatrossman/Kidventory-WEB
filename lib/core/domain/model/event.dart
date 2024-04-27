import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/online_location.dart';
import 'package:kidventory_flutter/core/domain/model/repeat.dart';
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
  final OnlineLocation? onlineLocation;
  final EventColor color;
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
    this.onlineLocation,
    required this.color,
    required this.inviteLink,
  });
}

enum PeriodUnit { day, week, monthDay, monthDate }

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
