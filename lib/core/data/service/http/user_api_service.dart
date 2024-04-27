import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';

abstract class UserApiService {
  Future<List<SessionDto>> getUpcomingSessions(DateTime datetime, int limit);

  Future<List<EventDto>> getEvents(int limit, int offset);
}
