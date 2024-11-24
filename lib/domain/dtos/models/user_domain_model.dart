import 'package:confession/core/base/domain_model.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/enums/user_enums.dart';

final class UserDomainModel implements DomainModel<User> {
  const UserDomainModel({
    required this.vocation,
    required this.age,
    required this.gender,
    required this.lastConfession,
  });

  @override
  factory UserDomainModel.fromJson(Map<String, dynamic> json) {
    return UserDomainModel(
      vocation: Vocation.values.byName(json['vocation'] as String),
      age: Age.values.byName(json['age'] as String),
      gender: Gender.values.byName(json['gender'] as String),
      lastConfession: json['lastConfession'] as String,
    );
  }

  const UserDomainModel.empty()
      : vocation = Vocation.single,
        age = Age.adult,
        gender = Gender.female,
        lastConfession = '';

  final Vocation vocation;
  final Age age;
  final Gender gender;
  final String lastConfession;

  @override
  UserDomainModel copyWith({
    Vocation? vocation,
    Age? age,
    Gender? gender,
    String? lastConfession,
  }) {
    return UserDomainModel(
      vocation: vocation ?? this.vocation,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      lastConfession: lastConfession ?? this.lastConfession,
    );
  }

  @override
  User toViewData() => User(
        vocation: vocation,
        age: age,
        gender: gender,
        lastConfession: lastConfession,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'vocation': vocation.name,
      'age': age.name,
      'gender': gender.name,
      'lastConfession': lastConfession,
    };
  }
}
