import 'package:kidventory_flutter/core/data/model/session_dto.dart';

abstract class UserApiService {

  Future<List<SessionDto>> getUpcomingSessions(DateTime datetime, int limit);

}