import 'dart:developer';

import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/core/base/view_data.dart';
import 'package:confession/exam/domain/usecases/update_examination_usecase.dart';

class UpdateExaminationBloc extends ModuleBloc<
    BlocEvent<UpdateExaminationParam>, PrimitiveViewData<int>> {
  UpdateExaminationBloc(
      {required UpdateExaminationUsecase updateExaminationUsecase,})
      : _updateExaminationUsecase = updateExaminationUsecase,
        super(const BlocState.loading()) {
    on<BlocEvent<UpdateExaminationParam>>(handleEvent);
  }

  final UpdateExaminationUsecase _updateExaminationUsecase;

  @override
  Future<void> handleEvent(
    BlocEvent<UpdateExaminationParam> event,
    Emitter<BlocState<PrimitiveViewData<int>>> emit,
  ) async {
    emit(const BlocState.loading());
    try {
      final updateCount = await _updateExaminationUsecase(event.argument);
      emit(BlocState.success(data: updateCount));
    } catch (e, st) {
      log('Error loading commandments', error: e, stackTrace: st);
      emit(const BlocState.error());
    }
  }
}
