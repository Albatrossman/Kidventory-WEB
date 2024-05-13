import 'package:json_annotation/json_annotation.dart';

part 'delete_account_dto.g.dart';

@JsonSerializable()
class DeleteAccountDto {
  final String email;
  final String password;

  DeleteAccountDto({
    required this.email,
    required this.password,
  });

  factory DeleteAccountDto.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteAccountDtoToJson(this);
}
