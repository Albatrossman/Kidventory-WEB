
class EditProfileScreenState {
  final String name;
  final String lastName;
  final String? imageAddress;

  EditProfileScreenState(
      {this.name = "",
      this.lastName = "",
      this.imageAddress});

  EditProfileScreenState copy(
      {String? name,
      String? lastName,
      String? imageAddress}) {
    return EditProfileScreenState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      imageAddress: imageAddress ?? this.imageAddress,
    );
  }
}
