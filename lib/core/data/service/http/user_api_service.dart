import 'package:kidventory_flutter/core/data/model/child_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';

abstract class UserApiService {
  Future<List<SessionDto>> getUpcomingSessions(DateTime datetime, int limit);

  Future<List<EventDto>> getEvents(int limit, int offset);

  Future<ProfileDto> getProfile(String id);

  Future<ProfileDto> updateProfile(String id);

  Future<ChildDto> addChild(String id);

  Future<ChildDto> updateChild(String id);

  Future<ChildDto> deleteChild(String id);
}
