import 'package:app_miles/app_miles.dart';

class SessionModel {
  Jwt? jwt;
  UserModel? user;

  SessionModel({
    this.jwt,
    this.user,
  });

  SessionModel copyWith({
    Jwt? jwt,
    UserModel? user,
  }) {
    return SessionModel(
      jwt: jwt ?? this.jwt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jwt': jwt?.toMap(),
      'user': user?.toMap(),
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    final jwt = map['jwt'] != null ? Jwt.fromMap(map['jwt']) : null;
    final user = map['user'] != null ? UserModel.fromMap(map['user']) : null;

    return SessionModel(
      jwt: jwt,
      user: user,
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionModel.fromJson(String source) {
    return SessionModel.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return 'SessionModel(jwt: $jwt, user: $user)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SessionModel && o.jwt == jwt && o.user == user;
  }

  @override
  int get hashCode {
    return jwt.hashCode ^ user.hashCode;
  }
}
