import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/core/errors/app_exception.dart';
import 'package:confession/core/errors/error_handler.dart';
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
  Future<void> handleEvent(
    BlocEvent<NoParams> event,
    Emitter<BlocState<PrayerList>> emit,
  ) async {
    emit(const BlocState.loading());
    try {
      final prayers = await _getPrayersUsecase();
      emit(BlocState.success(data: prayers));
    } catch (e, st) {
      // Handle error through centralized error handler
      final exception = e is AppException
          ? e
          : FeatureException(
              message: 'Error loading prayers',
              featureCode: 'PRAYERS',
              error: e,
              stackTrace: st,
            );
      await ErrorHandler.instance.handleException(exception, st);

      // Emit error state to update UI
      emit(const BlocState.error());
    }
  }
}
