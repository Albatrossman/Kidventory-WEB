// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repeat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepeatDto _$RepeatDtoFromJson(Map<String, dynamic> json) => RepeatDto(
      period: json['period'] as int,
      periodUnit: EnumSerializer.repeatUnitFromJson(json['periodUnit'] as int),
      daysOfWeek: EnumSerializer.weekDaysFromJson(json['weekDays'] as List),
      monthDay: EnumSerializer.weekDayFromJson(json['monthDay'] as int?),
      dayNumberOfMonth: json['dayNumberOfMonth'] as int,
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endsOnMode: EnumSerializer.repeatEndFromJson(json['endsOnMode'] as int),
      endDateTime: DateTime.parse(json['endDateTime'] as String),
      maxOccurrence: json['maxOccurrence'] as int,
    );

Map<String, dynamic> _$RepeatDtoToJson(RepeatDto instance) => <String, dynamic>{
      'period': instance.period,
      'periodUnit': EnumSerializer.toJson(instance.periodUnit),
      'weekDays': EnumSerializer.weekDaysToJson(instance.daysOfWeek),
      'monthDay': EnumSerializer.toJson(instance.monthDay),
      'dayNumberOfMonth': instance.dayNumberOfMonth,
      'startDateTime': DateTimeSerializer.toJson(instance.startDateTime),
      'endDateTime': DateTimeSerializer.toJson(instance.endDateTime),
      'endsOnMode': EnumSerializer.toJson(instance.endsOnMode),
      'maxOccurrence': instance.maxOccurrence,
    };
