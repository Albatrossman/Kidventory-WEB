import 'package:dio/dio.dart';
import 'package:kidventory_flutter/core/data/model/child_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/data/util/dio_client.dart';

class UserApiServiceImpl extends UserApiService {
  final DioClient client;

  UserApiServiceImpl(this.client);

  @override
  Future<List<SessionDto>> getUpcomingSessions(
      DateTime datetime, int limit) async {
    Response response = await client.dio.get(
        'users/me/getUpcomingSessions?pageSize=$limit&datetime=${'${datetime.toUtc().toIso8601String().split('.')[0]}Z'}');
    return response.data
        .map<SessionDto>((json) => SessionDto.fromJson(json))
        .toList();
  }

  @override
  Future<List<EventDto>> getEvents(int limit, int offset) async {
    Response response = await client.dio
        .get('users/events?limit=$limit&offset=$offset&IsOwner=true');
    return response.data
        .map<EventDto>((json) => EventDto.fromJson(json))
        .toList();
  }

  @override
  Future<ProfileDto> getProfile(String id) async {
    Response response = await client.dio.get('users/$id');
    
    return ProfileDto.fromJson(response.data);
  }

  @override
  Future<ProfileDto> updateProfile(String id) async {
    Response response = await client.dio.put('users/$id', data: null);
    return response.data.map<ProfileDto>((json) => ProfileDto.fromJson(json));
  }

  @override
  Future<ChildDto> addChild(String id) async {
    Response response = await client.dio.get('users/$id');
    return response.data.map<ChildDto>((json) => ChildDto.fromJson(json));
  }

  @override
  Future<ChildDto> updateChild(String id) async {
    Response response = await client.dio.get('users/$id');
    return response.data.map<ChildDto>((json) => ChildDto.fromJson(json));
  }

  @override
  Future<ChildDto> deleteChild(String id) async {
    Response response = await client.dio.get('users/$id');
    return response.data.map<ChildDto>((json) => ChildDto.fromJson(json));
  }
}
