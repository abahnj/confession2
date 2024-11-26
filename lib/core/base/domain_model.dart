import 'package:equatable/equatable.dart';

abstract class DomainModel extends Equatable {
  const DomainModel();

  static DomainModel fromJson(Map<String, dynamic> json) {
    throw UnsupportedError(
      'Cannot create a DomainModel directly. Use a specific implementation.',
    );
  }

  DomainModel copyWith();

  Map<String, dynamic> toJson();
}
