import 'package:kidventory_flutter/core/data/model/event_session_dto.dart';
import 'package:kidventory_flutter/core/data/model/add_member_dto.dart';
import 'package:kidventory_flutter/core/data/model/change_members_role_dto.dart';
import 'package:kidventory_flutter/core/data/model/create_event_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/invited_event_dto.dart';
import 'package:kidventory_flutter/core/data/model/join_from_invite_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/data/model/pending_members_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_invite_link_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_join_status_dto.dart';

abstract class EventApiService {

  Future<EventDto> createEvent(CreateEventDto event);

  Future<EventDto> getEvent(String id);

  Future<EventDto> editEvent(String id, EventDto event);

  Future<void> deleteEvent(String id);

  Future<void> addMembers(String eventId, AddMemberDto body);

  Future<List<ParticipantDto>> getMembers(String eventId, String sessionId);

  Future<void> deleteMember(String eventId, String memberId);

  Future<List<PendingMembersDto>> getPendingMembers(String eventId);

  Future<void> updatePendingMembers(String eventId, String requestId, UpdateJoinStatusDto body);

  Future<void> changeMemberRole(String eventId, ChangeMembersRoleDto membersRole);

  Future<List<EventSessionDto>> getSessions(String eventId);

  Future<InvitedEventDto> getEventFromReference(String id);

  Future<void> joinPublicEvent(String id, JoinFromInvitetDto body);

  Future<void> joinPrivateEvent(String id, JoinFromInvitetDto body);

  Future<void> updateInviteLink(String eventId, UpdateInviteLinkDto body);

  Future<void> updateAttendance(String eventId, String sessionId, UpdateAttendanceDto attendances);

}