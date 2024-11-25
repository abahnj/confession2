import 'package:confession/core/base/view_data.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/enums/user_enums.dart';

class User extends ViewData<UserDomainModel> {
  const User({
    required this.vocation,
    required this.age,
    required this.gender,
    required this.lastConfession,
  });

  const User.empty()
      : vocation = Vocation.single,
        age = Age.adult,
        gender = Gender.female,
        lastConfession = '';

  final Vocation vocation;
  final Age age;
  final Gender gender;
  final String lastConfession;

  User copyWith({
    Vocation? vocation,
    Age? age,
    Gender? gender,
    String? lastConfession,
  }) =>
      User(
        vocation: vocation ?? this.vocation,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        lastConfession: lastConfession ?? this.lastConfession,
      );

  @override
  UserDomainModel toDomain() => UserDomainModel(
        vocation: vocation,
        age: age,
        gender: gender,
        lastConfession: lastConfession,
      );

  @override
  List<Object?> get props => [vocation, age, gender, lastConfession];
}
