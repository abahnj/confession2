import 'dart:developer';

import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/exam/domain/entities/examination.dart';
import 'package:confession/exam/domain/usecases/get_examinations_usecase.dart';

class ExaminationsBloc extends ModuleBloc<BlocEvent<GetExaminationsParam>, ExaminationsList> {
  ExaminationsBloc({required GetExaminationsUsecase getExaminationsUsecase})
      : _getExaminationsUsecase = getExaminationsUsecase,
        super(const BlocState.loading()) {
    on<BlocEvent<GetExaminationsParam>>(handleEvent);
  }

  final GetExaminationsUsecase _getExaminationsUsecase;

  @override
  Future<void> handleEvent(BlocEvent<GetExaminationsParam> event, Emitter<BlocState<ExaminationsList>> emit) async {
    await emit.forEach(
      _getExaminationsUsecase(event.argument),
      onData: (examinations) => BlocState.success(data: examinations),
      onError: (e, st) {
        log('Error loading examinations', error: e, stackTrace: st);
        return const BlocState.error();
      },
    );
  }
}
