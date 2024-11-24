// ignore_for_file: one_member_abstracts

import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
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
