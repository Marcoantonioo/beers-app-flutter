import 'dart:convert';

class CredencialModel {
  final String? username;
  final String? password;

  CredencialModel({
    this.username,
    this.password,
  });

  CredencialModel copyWith({
    String? email,
    String? password,
  }) {
    return CredencialModel(
      username: email ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory CredencialModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return null!;

    return CredencialModel(
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CredencialModel.fromJson(String source) =>
      CredencialModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CredentialModel(username: $username, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CredencialModel &&
        o.username == username &&
        o.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
