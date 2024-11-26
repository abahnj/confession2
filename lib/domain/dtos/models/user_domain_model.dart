import 'package:confession/core/base/domain_model.dart';

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
      vocation: json['vocation'] as String,
      age: json['age'] as String,
      gender: json['gender'] as String,
      lastConfession: json['lastConfession'] as String,
    );
  }

  final String vocation;
  final String age;
  final String gender;
  final String lastConfession;

  @override
  UserDomainModel copyWith({
    String? vocation,
    String? age,
    String? gender,
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
      'vocation': vocation,
      'age': age,
      'gender': gender,
      'lastConfession': lastConfession,
    };
  }

  @override
  List<Object?> get props => [vocation, age, gender, lastConfession];
}
