import 'package:kidventory_flutter/core/data/model/add_member_dto.dart';
import 'package:kidventory_flutter/core/data/model/change_members_role_dto.dart';
import 'package:kidventory_flutter/core/data/model/create_event_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_attendance_dto.dart';

abstract class EventApiService {

  Future<EventDto> createEvent(CreateEventDto event);

  Future<EventDto> getEvent(String id);

  Future<EventDto> editEvent(String id, EventDto event);

  Future<void> deleteEvent(String id);

  Future<void> addMembers(String eventId, AddMemberDto body);

  Future<List<ParticipantDto>> getMembers(String eventId, String sessionId);

  Future<void> deleteMember(String eventId, String memberId);

  Future<void> changeMemberRole(String eventId, ChangeMembersRoleDto membersRole);

  Future<List<DateTime>> getSessions(String eventId);

<<<<<<< HEAD
  Future<EventDto> getEventFromReference(String id);
=======
  Future<void> updateAttendance(String eventId, String sessionId, UpdateAttendanceDto attendances);
>>>>>>> wip-backend-intergration

}