
class EditChildScreenState {
  final String name;
  final String lastName;
  final DateTime? birthday;
  final String relation;
  final String? imageAddress;

  EditChildScreenState(
      {this.name = "",
      this.lastName = "",
      this.birthday,
      this.relation = "None",
      this.imageAddress});

  EditChildScreenState copy(
      {String? name,
      String? lastName,
      DateTime? birthday,
      String? relation,
      String? imageAddress}) {
    return EditChildScreenState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birthday: birthday ?? this.birthday,
      relation: relation ?? this.relation,
      imageAddress: imageAddress ?? this.imageAddress,
    );
  }
}
