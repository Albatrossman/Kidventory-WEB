import 'package:dio/dio.dart';
import 'package:kidventory_flutter/core/data/model/add_member_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/util/dio_client.dart';

class EventApiServiceImpl extends EventApiService {

  final DioClient client;

  EventApiServiceImpl(this.client);

  @override
  Future<EventDto> createEvent(EventDto event) async {
    Response response = await client.dio.post('/v1/event', data: event.toJson());
    return EventDto.fromJson(response.data!);
  }

  @override
  Future<EventDto> getEvent(String id) async {
    Response response = await client.dio.get('/v1/event/$id');
    return EventDto.fromJson(response.data);
  }

  @override
  Future<EventDto> editEvent(String id, EventDto event) async {
    Response response = await client.dio.put('/v1/event/$id');
    return EventDto.fromJson(response.data);
  }

  @override
  Future<void> deleteEvent(String id) async {
    await client.dio.delete('/v1/event/$id');
  }

  @override
  Future<void> addMembers(String id, AddMemberDto body) async {
    await client.dio.delete('/v1/event/$id/member');
  }

}