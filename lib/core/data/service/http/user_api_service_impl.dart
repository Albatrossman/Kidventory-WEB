
import 'package:dio/dio.dart';
import 'package:kidventory_flutter/core/data/model/child_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_profile_dto.dart';
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
  Future<List<EventDto>> getEvents(int pageSize, int page) async {
    Response response = await client.dio
        .get('users/me/events?Page=$page&PageSize=$pageSize&IsOwner=true');
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
  Future<UpdateProfileDto> updateProfile(UpdateProfileDto body) async {
    Response response = await client.dio.put('users/me', data: body);
    return UpdateProfileDto.fromJson(response.data);
  }

  @override
  Future<ChildDto> addChild(ChildDto body) async {
    Response response = await client.dio.post(
      'users/me/childs',
      data: body.toJson(),
    );

    if (response.statusCode == 200) {
      return ChildDto.fromJson(response.data);
    } else {
      throw Exception('Failed to create child');
    }
  }

  @override
  Future<ChildDto> updateChild(String id, ChildDto body) async {
    Response response = await client.dio.put(
      'users/me/childs/$id',
      data: body.toJson(),
    );

    if (response.statusCode == 200) {
      return ChildDto.fromJson(response.data);
    } else {
      throw Exception('Failed to update child');
    }
  }

  @override
  Future<void> deleteChild(String id) async {
    Response response = await client.dio.delete(
      'users/me/childs/$id',
    );

    if (response.statusCode == 200) {
      //success
    } else {
      throw Exception('Failed to delete child');
    }
  }
}
