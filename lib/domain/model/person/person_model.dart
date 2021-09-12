import 'package:app_miles/app_miles.dart';

class PersonModel extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? birthdate;
  final String? rg;
  final String? cpf;

  PersonModel({
    this.firstName,
    this.lastName,
    this.birthdate,
    this.rg,
    this.cpf,
  });

  PersonModel copyWith({
    String? firstName,
    String? lastName,
    String? birthdate,
    String? rg,
    String? cpf,
  }) {
    return PersonModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthdate: birthdate ?? this.birthdate,
      rg: rg ?? this.rg,
      cpf: cpf ?? this.cpf,
    );
  }

  @override
  List get props => [
        firstName,
        lastName,
        birthdate,
        rg,
        cpf,
      ];

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "birthdate": birthdate,
      "rg": rg,
      "cpf": cpf,
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return null!;

    return PersonModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      birthdate: map['birthdate'],
      rg: map['rg'],
      cpf: map['cpf'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String? source) =>
      source == null ? null! : PersonModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PersonModel &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.birthdate == birthdate &&
        o.rg == rg &&
        o.cpf == cpf;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        birthdate.hashCode ^
        rg.hashCode ^
        cpf.hashCode;
  }
}