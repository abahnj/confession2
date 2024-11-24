import 'package:confession/core/base/view_data.dart';

abstract interface  class DomainModel<T extends ViewData<DomainModel<T>>> {
  const DomainModel();

  T toViewData();
  DomainModel<T> copyWith();
}
