import 'package:kidventory_flutter/core/data/model/online_location_dto.dart';
import 'package:kidventory_flutter/core/domain/model/online_location.dart';
import 'package:kidventory_flutter/core/domain/model/platform.dart';

extension DataExtension on OnlineLocationDto {
  OnlineLocation toDomain() {
    return OnlineLocation(
      platform: Platform.values.firstWhere(
              (e) => e.toString().split('.').last.toLowerCase() == meetingApp.toLowerCase(),
          orElse: () => Platform.meet  // Handle case where meetingApp does not match any Platform enum
      ),
      link: sessionLink,
      meetingId: meetingId.isNotEmpty ? meetingId : null,
      password: password.isNotEmpty ? password : null,
      comment: comment.isNotEmpty ? comment : null,
      phone: phone.isNotEmpty ? phone : null,
      pin: pin.isNotEmpty ? pin : null,
    );
  }
}

extension DomainExtension on OnlineLocation {
  OnlineLocationDto toData() {
    return OnlineLocationDto(
      meetingApp: platform.toString().split('.').last,
      sessionLink: link,
      meetingId: meetingId ?? '',
      password: password ?? '',
      comment: comment ?? '',
      phone: phone ?? '',
      pin: pin ?? '',
    );
  }
}
