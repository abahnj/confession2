import 'package:confession/core/base/view_data.dart';

abstract interface class DomainModel<T extends ViewData<DomainModel<T>>> {
  const DomainModel();

  static DomainModel fromJson(Map<String, dynamic> json) {
    throw UnsupportedError(
      'Cannot create a DomainModel directly. Use a specific implementation.',
    );
  }

  T toViewData();
  DomainModel<T> copyWith();

  Map<String, dynamic> toJson();
}
