import 'package:confession/core/base/domain_model.dart';
import 'package:confession/core/base/view_data.dart';
import 'package:drift/drift.dart';

abstract class ViewDataMapper<V extends ViewData, M extends DomainModel> {
  V toViewData(M model);
  M toDomainModel(V viewData);
}

abstract class ViewDataTableMapper<V extends ViewData, M extends DataClass, I extends Insertable<M>> {
  V toViewData(M model);
  I toInsertable(V viewData);
}
