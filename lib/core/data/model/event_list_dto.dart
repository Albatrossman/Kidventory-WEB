import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';

part 'event_list_dto.g.dart';

@JsonSerializable()
class EventListDto {
  final List<EventDto> items;
  final int currentPage;
  final int pageCount;
  final int totalCount;

  EventListDto({
    required this.items,
    required this.currentPage,
    required this.pageCount,
    required this.totalCount,
  });

  factory EventListDto.fromJson(Map<String, dynamic> json) => _$EventListDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EventListDtoToJson(this);
}