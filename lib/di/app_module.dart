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
import 'package:kidventory_flutter/core/data/util/downloader/default_downloader.dart';
import 'package:kidventory_flutter/core/data/util/downloader/downloader.dart';
import 'package:kidventory_flutter/core/domain/model/token.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  var storage = const FlutterSecureStorage();

  getIt.registerLazySingleton<TokenPreferencesManager>(
      () => TokenPreferencesManagerImpl(storage: storage));

  Token? token = await getIt<TokenPreferencesManager>().getToken();

  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      "https://kidventory.aftersearch.com/v1/",
      token?.accessToken ?? "",
    ),
  );

  getIt.registerLazySingleton<AuthApiService>(
      () => AuthApiServiceImpl(getIt<DioClient>()));
  getIt.registerLazySingleton<UserApiService>(
      () => UserApiServiceImpl(getIt<DioClient>()));
  getIt.registerLazySingleton<EventApiService>(
      () => EventApiServiceImpl(getIt<DioClient>()));
  getIt.registerLazySingleton<CSVParser>(() => ParticipantCSVParser());
  getIt.registerLazySingleton<Downloader>(() => DefaultDownloader(getIt<DioClient>()));
}

// Method to update singletons
Future<void> updateSingletons(String accessToken) async {
  await getIt.reset(dispose: true);

  var storage = const FlutterSecureStorage();

  getIt.registerLazySingleton<TokenPreferencesManager>(
      () => TokenPreferencesManagerImpl(storage: storage));

  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      "https://kidventory.aftersearch.com/v1/",
      accessToken,
    ),
  );

  getIt.registerLazySingleton<AuthApiService>(
      () => AuthApiServiceImpl(getIt<DioClient>()));
  getIt.registerLazySingleton<UserApiService>(
      () => UserApiServiceImpl(getIt<DioClient>()));
  getIt.registerLazySingleton<EventApiService>(
      () => EventApiServiceImpl(getIt<DioClient>()));
  getIt.registerLazySingleton<CSVParser>(() => ParticipantCSVParser());
  getIt.registerLazySingleton<Downloader>(() => DefaultDownloader(getIt<DioClient>()));
}
