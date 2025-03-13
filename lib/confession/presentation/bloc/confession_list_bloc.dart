import 'dart:developer';

import 'package:confession/confession/domain/usecases/get_confession_list_usecase.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/exam/domain/entities/examination.dart';

class ConfessionListBloc extends ModuleBloc<BlocEvent<NoParams>, ExaminationsList> {
  ConfessionListBloc({
    required GetActiveExaminationsUsecase getExaminationsUsecase,
  })  : _getExaminationsUsecase = getExaminationsUsecase,
        super(const BlocState.loading()) {
    on<BlocEvent<NoParams>>(handleEvent);
  }

  final GetActiveExaminationsUsecase _getExaminationsUsecase;

  @override
  Future<void> handleEvent(
    BlocEvent<NoParams> event,
    Emitter<BlocState<ExaminationsList>> emit,
  ) async {
    await emit.forEach(
      _getExaminationsUsecase(),
      onData: (examinations) => BlocState.success(data: examinations),
      onError: (e, st) {
        log('Error loading examinations', error: e, stackTrace: st);
        return const BlocState.error();
      },
    );
  }
}
