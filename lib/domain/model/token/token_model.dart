import 'package:app_miles/app_miles.dart';

class Jwt {
  final String? token;

  Jwt({this.token});

  Jwt copyWith({
    String? token,
  }) {
    return Jwt(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  factory Jwt.fromMap(Map<String, dynamic> map) {
    
    return Jwt(
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Jwt.fromJson(String source) => Jwt.fromMap(json.decode(source));

  @override
  String toString() => 'CredentialModel(token: $token)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Jwt && o.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
