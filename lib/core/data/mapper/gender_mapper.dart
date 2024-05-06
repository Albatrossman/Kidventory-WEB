import 'package:kidventory_flutter/core/data/model/gender_dto.dart';
import 'package:kidventory_flutter/core/domain/model/gender.dart';

extension DataExtension on GenderDto {
  Gender toData() {
    switch (this) {
      case GenderDto.none:
        return Gender.none;
      case GenderDto.male:
        return Gender.male;
      case GenderDto.female:
        return Gender.female;
      case GenderDto.nonBinary:
        return Gender.nonBinary;
      default:
        throw GenderDto.none;
    }
  }
}

extension DomainExtension on Gender {
  GenderDto toData() {
    switch (this) {
      case Gender.none:
        return GenderDto.none;
      case Gender.male:
        return GenderDto.male;
      case Gender.female:
        return GenderDto.female;
      case Gender.nonBinary:
        return GenderDto.nonBinary;
      default:
        throw GenderDto.none;
    }
  }
}