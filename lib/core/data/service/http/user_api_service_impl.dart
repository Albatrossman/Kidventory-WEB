import 'package:dio/dio.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/data/util/dio_client.dart';

class UserApiServiceImpl extends UserApiService {

  final DioClient client;

  UserApiServiceImpl(this.client);

  @override
  Future<List<SessionDto>> getUpcomingSessions(DateTime datetime, int limit) async {
    Response response = await client.dio.get('users/me/getUpcomingSessions?pageSize=$limit&datetime=${'${datetime.toUtc().toIso8601String().split('.')[0]}Z'}');
    return response.data.map<SessionDto>((json) => SessionDto.fromJson(json)).toList();
  }

  @override
  Future<List<EventDto>> getEvents(int limit, int offset) async {
    Response response = await client.dio.get('parent/events?limit=$limit&offset=$offset&IsOwner=true');
    return response.data.map<EventDto>((json) => EventDto.fromJson(json)).toList();
  }

}