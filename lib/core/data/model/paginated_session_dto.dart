import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';

part 'paginated_session_dto.g.dart';

@JsonSerializable()
class PaginatedSessionDto {
  final List<SessionDto> result;
  final int currentPage;
  final int pageCount;
  final int totalCount;

  PaginatedSessionDto({
    required this.result,
    required this.currentPage,
    required this.pageCount,
    required this.totalCount,
  });

  factory PaginatedSessionDto.fromJson(Map<String, dynamic> json) => _$PaginatedSessionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PaginatedSessionDtoToJson(this);
}