import 'package:confession/core/base/view_data.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:intl/intl.dart';

class User extends ViewData {
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

  String get formattedLastConfession => _formatDateTime(lastConfession);

  String _formatDateTime(String isoString) {
    final date = DateTime.tryParse(isoString);

    if (date == null) return isoString;

    final formatter = DateFormat('EEEE, MMMM d, y');
    return formatter.format(date);
  }

  @override
  List<Object?> get props => [vocation, age, gender, lastConfession];
}
