import 'dart:developer';

import 'package:confession/confession/domain/usecases/reset_active_examinations_usecase.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/core/base/view_data.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/domain/usecases/user_usecases.dart';

class FinishConfessionBloc extends ModuleBloc<BlocEvent<NoParams>, EmptyViewData> {
  FinishConfessionBloc({
    required ResetActiveExaminationsUsecase resetActiveExaminationsUsecase,
    required GetUserUseCase getUserUseCase,
    required SaveUserUseCase saveUserUseCase,
  })  : _resetActiveExaminationsUsecase = resetActiveExaminationsUsecase,
        _getUserUseCase = getUserUseCase,
        _saveUserUseCase = saveUserUseCase,
        super(const BlocState.loading()) {
    on<BlocEvent<NoParams>>(handleEvent);
  }

  final ResetActiveExaminationsUsecase _resetActiveExaminationsUsecase;
  final GetUserUseCase _getUserUseCase;
  final SaveUserUseCase _saveUserUseCase;

  @override
  Future<void> handleEvent(
    BlocEvent<NoParams> event,
    Emitter<BlocState<EmptyViewData>> emit,
  ) async {
    emit(const BlocState.loading());
    try {
      await _resetActiveExaminationsUsecase();
      final user = await _getUserUseCase();
      await _saveUserUseCase(
        SaveUserParam(
          user: user.copyWith(lastConfession: DateTime.now().toIso8601String()),
        ),
      );
      emit(const BlocState.success(data: EmptyViewData()));
    } catch (e, st) {
      log('Error loading prayers', error: e, stackTrace: st);
      emit(const BlocState.error());
    }
  }
}
