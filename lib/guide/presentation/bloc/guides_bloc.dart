import 'dart:developer';

import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/guide/domain/entities/guide.dart';
import 'package:confession/guide/usecases/get_guides_usecase.dart';

class GuidesBloc extends ModuleBloc<BlocEvent<GuideParam>, GuideList> {
  GuidesBloc({required GetGuidesUsecase getGuidesUsecase})
      : _getGuidesUsecase = getGuidesUsecase,
        super(const BlocState.loading()) {
    on<BlocEvent<GuideParam>>(handleEvent);
  }

  final GetGuidesUsecase _getGuidesUsecase;

  @override
  Future<void> handleEvent(
    BlocEvent<GuideParam> event,
    Emitter<BlocState<GuideList>> emit,
  ) async {
    emit(const BlocState.loading());
    try {
      final guides = await _getGuidesUsecase(event.argument);
      emit(BlocState.success(data: guides));
    } catch (e, st) {
      log('Error loading prayers', error: e, stackTrace: st);
      emit(const BlocState.error());
    }
  }
}
