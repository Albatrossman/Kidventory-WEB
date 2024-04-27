// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repeat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepeatDto _$RepeatDtoFromJson(Map<String, dynamic> json) => RepeatDto(
      id: json['id'] as String,
      period: json['period'] as int,
      periodUnit: json['periodUnit'] as String,
      weekDays:
          (json['weekDays'] as List<dynamic>).map((e) => e as String).toList(),
      monthDay: json['monthDay'] as String,
      dayNumberOfMonth: json['dayNumberOfMonth'] as int,
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endsOnMode: json['endsOnMode'] as String,
      endDate: DateTime.parse(json['endDate'] as String),
      maxOccurrence: json['maxOccurrence'] as int,
    );

Map<String, dynamic> _$RepeatDtoToJson(RepeatDto instance) => <String, dynamic>{
      'id': instance.id,
      'period': instance.period,
      'periodUnit': instance.periodUnit,
      'weekDays': instance.weekDays,
      'monthDay': instance.monthDay,
      'dayNumberOfMonth': instance.dayNumberOfMonth,
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endsOnMode': instance.endsOnMode,
      'endDate': instance.endDate.toIso8601String(),
      'maxOccurrence': instance.maxOccurrence,
    };
