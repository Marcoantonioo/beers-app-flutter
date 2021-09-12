import 'package:app_miles/app_miles.dart';

class UserModel extends Equatable {
  final String? password;
  final String? username;
  final PersonModel? person;

  UserModel({
    this.password,
    this.username,
    this.person,
  });

  UserModel copyWith({
    String? password,
    String? username,
    PersonModel? person,
  }) {
    return UserModel(
      password: password ?? this.password,
      username: username ?? this.username,
      person: person ?? this.person,
    );
  }

  @override
  List get props => [
        password,
        username,
        person,
      ];

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'username': username,
      'person': person?.toMap()
    };
  }

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return null!;

    return UserModel(
      password: map['password'],
      username: map['username'],
      person: PersonModel.fromMap(map['person']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String? source) =>
      source == null ? null! : UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SessionModel(password: $password, username: $username, person: $person)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.password == password &&
        o.username == username &&
        o.person == person;
  }

  @override
  int get hashCode {
    return password.hashCode ^ username.hashCode ^ person.hashCode;
  }
}
