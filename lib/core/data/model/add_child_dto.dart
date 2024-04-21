class ChildDto {
  final String id;
  final String? sessionId;
  final String? avatarUrl;
  final String firstname;
  final String lastname;
  final String? email;
  final List<String>? phones;
  final int? age;
  final String? gender;
  final String? parent;
  final String? guardian;
  final String? address;

  ChildDto({
    required this.id,
    this.sessionId,
    this.avatarUrl,
    required this.firstname,
    required this.lastname,
    this.email,
    this.phones,
    this.age,
    this.gender,
    this.parent,
    this.guardian,
    this.address,
  });

  factory ChildDto.fromJson(Map<String, dynamic> json) {
    return ChildDto(
      id: json['id'],
      sessionId: json['sessionId'],
      avatarUrl: json['avatarUrl'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phones: List<String>.from(json['phones']),
      age: json['age'],
      gender: json['gender'],
      parent: json['parent'],
      guardian: json['guardian'],
      address: json['address'],
    );
  }
}
