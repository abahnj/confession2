import 'package:confession/core/base/domain_model.dart';
import 'package:equatable/equatable.dart';

abstract class ViewData<T extends DomainModel<ViewData<T>>> extends Equatable {
  const ViewData();

  T toDomain();
}
