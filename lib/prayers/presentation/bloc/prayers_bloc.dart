import 'dart:developer';

import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';
import 'package:confession/prayers/domain/usecases/get_prayers_usecase.dart';

class PrayersBloc extends ModuleBloc<BlocEvent<NoParams>, PrayerList> {
  PrayersBloc({required GetPrayersUsecase getPrayersUsecase})
      : _getPrayersUsecase = getPrayersUsecase,
        super(const BlocState.loading()) {
    on<BlocEvent<NoParams>>(handleEvent);
  }

  final GetPrayersUsecase _getPrayersUsecase;

  @override
  Future<void> handleEvent(BlocEvent<NoParams> event, Emitter<BlocState<PrayerList>> emit) async {
    emit(const BlocState.loading());
    try {
      final prayers = await _getPrayersUsecase();
      emit(BlocState.success(data: prayers));
    } catch (e, st) {
      log('Error loading prayers', error: e, stackTrace: st);
      emit(const BlocState.error());
    }
  }
}
