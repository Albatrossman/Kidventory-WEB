
import 'package:kidventory_flutter/core/data/model/child_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_profile_dto.dart';

abstract class UserApiService {
  Future<List<SessionDto>> getUpcomingSessions(DateTime datetime, int limit);

  Future<List<EventDto>> getEvents(int pageSize, int page);

  Future<ProfileDto> getProfile(String id);

  Future<UpdateProfileDto> updateProfile(UpdateProfileDto body);

  Future<ChildDto> addChild(ChildDto body);

  Future<ChildDto> updateChild(String id, ChildDto body);

  Future<void> deleteChild(String id);
}
