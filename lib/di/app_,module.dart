import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:kidventory_flutter/core/data/service/csv/csv_parser.dart';
import 'package:kidventory_flutter/core/data/service/csv/participant_csv_parser.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service_impl.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service_impl.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service_impl.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager_impl.dart';
import 'package:kidventory_flutter/core/data/util/dio_client.dart';
import 'package:kidventory_flutter/core/domain/model/token.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  var storage = const FlutterSecureStorage();
  var tokenManager = TokenPreferencesManagerImpl(storage: storage);

  getIt.registerSingleton<TokenPreferencesManager>(tokenManager);

  Token? token = await tokenManager.getToken();

  getIt.registerSingleton<DioClient>(
    DioClient(
      "https://dev-kidsapi.softballforce.com/v1/",
      token?.accessToken ?? "",
    ),
  );
  getIt.registerSingleton<AuthApiService>(AuthApiServiceImpl(getIt<DioClient>()));
  getIt.registerSingleton<UserApiService>(UserApiServiceImpl(getIt<DioClient>()));
  getIt.registerSingleton<EventApiService>(EventApiServiceImpl(getIt<DioClient>()));
  getIt.registerSingleton<CSVParser>(ParticipantCSVParser());
}
