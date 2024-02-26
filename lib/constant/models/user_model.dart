import 'dart:convert';
// ignore_for_file: non_constant_identifier_names

class User {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String company_id;
  final String token;
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.company_id,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'role': role,
      'company_id': company_id,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      company_id: map['company_id'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
