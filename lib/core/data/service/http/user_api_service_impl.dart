import 'package:dio/dio.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/data/util/dio_client.dart';

class UserApiServiceImpl extends UserApiService {

  final DioClient client;

  UserApiServiceImpl(this.client);

  @override
  Future<List<SessionDto>> getUpcomingSessions(DateTime datetime, int limit) async {
    Response response = await client.dio.get('parent/getUpcomingSessions');
    return response.data.map((json) => SessionDto.fromJson(json)).toList();
  }

}