import 'dart:developer';

import 'package:confession/confession/domain/usecases/get_examination_of_conscience.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';

class ExaminationOfConscienceBloc extends ModuleBloc<BlocEvent<NoParams>, Prayer> {
  ExaminationOfConscienceBloc({
    required GetExaminationOfConscienceUsecase getExaminationOfConscienceUsecase,
  })  : _examinationOfConscienceUsecase = getExaminationOfConscienceUsecase,
        super(const BlocState.loading()) {
    on<BlocEvent<NoParams>>(handleEvent);
  }

  final GetExaminationOfConscienceUsecase _examinationOfConscienceUsecase;

  @override
  Future<void> handleEvent(
    BlocEvent<NoParams> event,
    Emitter<BlocState<Prayer>> emit,
  ) async {
    emit(const BlocState.loading());
    try {
      final prayer = await _examinationOfConscienceUsecase();
      emit(BlocState.success(data: prayer));
    } catch (e, st) {
      log('Error loading prayer', error: e, stackTrace: st);
      emit(const BlocState.error());
    }
  }
}
