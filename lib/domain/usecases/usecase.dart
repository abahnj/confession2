// ignore_for_file: one_member_abstracts

import 'package:confession/core/base/view_data.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase {
  void call();
}

abstract class AsyncUseCase {
  Future<void> call();
}

abstract class ParamUseCase<Type extends Param> {
  void call(Type param);
}

abstract class AsyncParamUseCase<Type extends Param> {
  Future<void> call(Type param);
}

abstract class AsyncViewDataUseCase<Type extends ViewData> {
  Future<Type> call();
}

abstract class AsyncViewDataParamUseCase<Type extends ViewData,
    ParamType extends Param> {
  Future<Type> call(ParamType param);
}

abstract class StreamViewDataParamUseCase<Type extends ViewData,
    ParamType extends Param> {
  Stream<Type> call(ParamType param);
}

abstract class StreamViewDataUseCase<Type extends ViewData> {
  Stream<Type> call();
}

abstract class Param extends Equatable {
  const Param();
}

class NoParams extends Param {
  const NoParams();

  @override
  List<Object?> get props => [];
}

const noParam = NoParams();
