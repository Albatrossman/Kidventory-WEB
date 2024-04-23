import 'package:kidventory_flutter/core/data/model/add_member_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';

abstract class EventApiService {

  Future<EventDto> createEvent(EventDto event);

  Future<EventDto> getEvent(String id);

  Future<EventDto> editEvent(String id, EventDto event);

  Future<void> deleteEvent(String id);

  Future<void> addMembers(String id, AddMemberDto body);

}