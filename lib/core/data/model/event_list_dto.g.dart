// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventListDto _$EventListDtoFromJson(Map<String, dynamic> json) => EventListDto(
      items: (json['items'] as List<dynamic>)
          .map((e) => EventDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['currentPage'] as int,
      pageCount: json['pageCount'] as int,
      totalCount: json['totalCount'] as int,
    );

Map<String, dynamic> _$EventListDtoToJson(EventListDto instance) =>
    <String, dynamic>{
      'items': instance.items,
      'currentPage': instance.currentPage,
      'pageCount': instance.pageCount,
      'totalCount': instance.totalCount,
    };
