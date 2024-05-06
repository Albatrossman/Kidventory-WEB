import 'package:kidventory_flutter/core/domain/model/platform.dart';

class OnlineLocation {
  final Platform platform;
  final String link;
  final String? meetingId;
  final String? password;
  final String? comment;
  final String? phone;
  final String? pin;

  OnlineLocation({
    required this.platform,
    required this.link,
    this.meetingId,
    this.password,
    this.comment,
    this.phone,
    this.pin,
  });
}