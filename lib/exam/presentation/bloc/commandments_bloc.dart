import 'dart:developer';

import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/exam/domain/entities/commandment.dart';
import 'package:confession/exam/domain/usecases/get_commandments_usecase.dart';

class CommandmentsBloc
    extends ModuleBloc<BlocEvent<GetCommandmentsParam>, CommandmentList> {
  CommandmentsBloc({required GetCommandmentsUsecase getCommandmentsUsecase})
      : _getCommandmentsUsecase = getCommandmentsUsecase,
        super(const BlocState.loading()) {
    on<BlocEvent<GetCommandmentsParam>>(handleEvent);
  }

  final GetCommandmentsUsecase _getCommandmentsUsecase;

  @override
  Future<void> handleEvent(
    BlocEvent<GetCommandmentsParam> event,
    Emitter<BlocState<CommandmentList>> emit,
  ) async {
    emit(const BlocState.loading());
    try {
      final commandments = await _getCommandmentsUsecase(event.argument);
      emit(BlocState.success(data: commandments));
    } catch (e, st) {
      log('Error loading commandments', error: e, stackTrace: st);
      emit(const BlocState.error());
    }
  }
}
