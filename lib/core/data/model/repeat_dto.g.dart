// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repeat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepeatDto _$RepeatDtoFromJson(Map<String, dynamic> json) => RepeatDto(
      period: json['period'] as int,
      periodUnit: $enumDecode(_$RepeatUnitEnumMap, json['periodUnit']),
      daysOfWeek:
          (json['weekDays'] as List<dynamic>).map((e) => e as String).toList(),
      monthDay: $enumDecodeNullable(_$WeekDayEnumMap, json['monthDay']),
      dayNumberOfMonth: json['dayNumberOfMonth'] as int,
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endsOnMode: $enumDecode(_$RepeatEndEnumMap, json['endsOnMode']),
      endDateTime: DateTime.parse(json['endDateTime'] as String),
      maxOccurrence: json['maxOccurrence'] as int,
    );

Map<String, dynamic> _$RepeatDtoToJson(RepeatDto instance) => <String, dynamic>{
      'period': instance.period,
      'periodUnit': EnumSerializer.toJson(instance.periodUnit),
      'weekDays': instance.daysOfWeek,
      'monthDay': EnumSerializer.toJson(instance.monthDay),
      'dayNumberOfMonth': instance.dayNumberOfMonth,
      'startDateTime': DateTimeSerializer.toJson(instance.startDateTime),
      'endDateTime': DateTimeSerializer.toJson(instance.endDateTime),
      'endsOnMode': EnumSerializer.toJson(instance.endsOnMode),
      'maxOccurrence': instance.maxOccurrence,
    };

const _$RepeatUnitEnumMap = {
  RepeatUnit.day: 'day',
  RepeatUnit.week: 'week',
  RepeatUnit.month: 'month',
};

const _$WeekDayEnumMap = {
  WeekDay.sunday: 'sunday',
  WeekDay.monday: 'monday',
  WeekDay.tuesday: 'tuesday',
  WeekDay.wednesday: 'wednesday',
  WeekDay.thursday: 'thursday',
  WeekDay.friday: 'friday',
  WeekDay.saturday: 'saturday',
};

const _$RepeatEndEnumMap = {
  RepeatEnd.onDate: 'onDate',
  RepeatEnd.afterOccurrence: 'afterOccurrence',
};
