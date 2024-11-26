import 'package:confession/core/base/domain_model.dart';
import 'package:confession/core/base/view_data.dart';

abstract class ViewDataMapper<V extends ViewData, M extends DomainModel> {
  V toViewData(M model);
  M toDomainModel(V viewData);
}
