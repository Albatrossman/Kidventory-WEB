import 'package:kidventory_flutter/core/data/model/event_session_dto.dart';
import 'package:kidventory_flutter/core/domain/model/event_session.dart';

extension DataExtension on EventSessionDto {
  EventSession toDomain() {
    return EventSession(
      id: id,
      title: title,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );
  }
}
