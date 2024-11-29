import 'package:equatable/equatable.dart';

abstract class ViewData extends Equatable {
  const ViewData();
}

abstract class ViewDataList<V extends ViewData> extends Equatable {
  const ViewDataList({required this.data});

  final List<V> data;
}

class EmptyViewData extends ViewData {
  const EmptyViewData();

  @override
  List<Object> get props => [];
}

class PrimitiveViewData<T extends Object> extends ViewData {
  const PrimitiveViewData({required this.data});

  final T data;

  @override
  List<Object> get props => [data];
}
