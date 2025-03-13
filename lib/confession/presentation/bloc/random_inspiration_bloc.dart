import 'dart:developer';

import 'package:confession/confession/domain/usecases/get_random_inspiration_usecase.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/prayers/domain/entities/inspiration.dart';

class RandomInspirationBloc extends ModuleBloc<BlocEvent<NoParams>, Inspiration> {
  RandomInspirationBloc({
    required GetRandomInspirationUsecase inspirationUsecase,
  })  : _inspirationUsecase = inspirationUsecase,
        super(const BlocState.loading()) {
    on<BlocEvent<NoParams>>(handleEvent);
  }

  final GetRandomInspirationUsecase _inspirationUsecase;

  @override
  Future<void> handleEvent(
    BlocEvent<NoParams> event,
    Emitter<BlocState<Inspiration>> emit,
  ) async {
    emit(const BlocState.loading());
    try {
      final inspiration = await _inspirationUsecase();
      emit(BlocState.success(data: inspiration));
    } catch (e, st) {
      log('Error loading prayers', error: e, stackTrace: st);
      emit(const BlocState.error());
    }
  }
}
