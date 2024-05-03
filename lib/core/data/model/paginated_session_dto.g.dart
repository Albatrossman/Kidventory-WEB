// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedSessionDto _$PaginatedSessionDtoFromJson(Map<String, dynamic> json) =>
    PaginatedSessionDto(
      result: (json['result'] as List<dynamic>)
          .map((e) => SessionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['currentPage'] as int,
      pageCount: json['pageCount'] as int,
      totalCount: json['totalCount'] as int,
    );

Map<String, dynamic> _$PaginatedSessionDtoToJson(
        PaginatedSessionDto instance) =>
    <String, dynamic>{
      'result': instance.result,
      'currentPage': instance.currentPage,
      'pageCount': instance.pageCount,
      'totalCount': instance.totalCount,
    };
