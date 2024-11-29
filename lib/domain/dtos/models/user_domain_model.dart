import 'package:confession/core/base/domain_model.dart';
import 'package:confession/domain/enums/user_enums.dart';

final class UserDomainModel extends DomainModel {
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
  Map<String, dynamic> toJson() {
    return {
      'vocation': vocation.name,
      'age': age.name,
      'gender': gender.name,
      'lastConfession': lastConfession,
    };
  }

  @override
  List<Object?> get props => [vocation, age, gender, lastConfession];
}
