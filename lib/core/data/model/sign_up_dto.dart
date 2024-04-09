class SignUpDto {
  final String email;
  final String firstname;
  final String lastname;
  final String password;
  final String timezone;

  SignUpDto({
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.password,
    required this.timezone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstname,
      'lastName': lastname,
      'password': password,
      'timeZone': timezone,
    };
  }

  factory SignUpDto.fromJson(Map<String, dynamic> json) {
    return SignUpDto(
      email: json['email'],
      firstname: json['firstName'],
      lastname: json['lastName'],
      password: json['password'],
      timezone: json['timeZone'],
    );
  }
}
