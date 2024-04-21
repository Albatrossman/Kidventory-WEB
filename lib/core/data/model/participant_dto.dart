enum Gender {
  male,
  female,
  other,
}

enum Role {
  student,
  teacher,
  parent,
}

enum Attendance {
  present,
  absent,
}

class ParticipantDto {
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
  final String role;
  final String? attendance;

  ParticipantDto({
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
    required this.role,
    this.attendance,
  });

  factory ParticipantDto.fromJson(Map<String, dynamic> json) {
    return ParticipantDto(
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
      role: json['role'],
      attendance: json['attendance'],
    );
  }
}
