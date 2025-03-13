import 'dart:developer';

import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/core/base/view_data.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/exam/domain/entities/examination.dart';
import 'package:confession/exam/domain/usecases/delete_examination_usecase.dart';
import 'package:confession/exam/domain/usecases/edit_examination_usecase.dart';
import 'package:confession/exam/domain/usecases/reset_examination_usecase.dart';
import 'package:confession/exam/domain/usecases/update_count_examination_usecase.dart';

class UpdateExaminationBloc
    extends ModuleBloc<BlocEvent<ExaminationEvent>, PrimitiveViewData<int>> {
  UpdateExaminationBloc({
    required UpdateCountExaminationUsecase updateExaminationUsecase,
    required EditExaminationUsecase editExaminationUsecase,
    required ResetExaminationUsecase resetExaminationUsecase,
    required DeleteExaminationUsecase deleteExaminationUsecase,
  })  : _updateExaminationUsecase = updateExaminationUsecase,
        _editExaminationUsecase = editExaminationUsecase,
        _resetExaminationUsecase = resetExaminationUsecase,
        _deleteExaminationUsecase = deleteExaminationUsecase,
        super(const BlocState.loading()) {
    on<BlocEvent<ExaminationEvent>>(handleEvent);
  }

  final UpdateCountExaminationUsecase _updateExaminationUsecase;
  final EditExaminationUsecase _editExaminationUsecase;
  final ResetExaminationUsecase _resetExaminationUsecase;
  final DeleteExaminationUsecase _deleteExaminationUsecase;

  Future<void> _onUpdateCount(
    UpdateCount event,
    Emitter<BlocState<PrimitiveViewData<int>>> emit,
  ) async {
    final updateCount = await _updateExaminationUsecase(event);
    emit(BlocState.success(data: updateCount));
  }

  Future<void> _onEditExamination(
    EditExamination event,
    Emitter<BlocState<PrimitiveViewData<int>>> emit,
  ) async {
    final editExamination = await _editExaminationUsecase(event);
    emit(BlocState.success(data: editExamination));
  }

  Future<void> _onResetText(
    ResetText event,
    Emitter<BlocState<PrimitiveViewData<int>>> emit,
  ) async {
    final resetText = await _resetExaminationUsecase(event);
    emit(BlocState.success(data: resetText));
  }

  Future<void> _onDeleteExamination(
    DeleteExamination event,
    Emitter<BlocState<PrimitiveViewData<int>>> emit,
  ) async {
    final deleteExamination = await _deleteExaminationUsecase(event);
    emit(BlocState.success(data: deleteExamination));
  }

  @override
  Future<void> handleEvent(
    BlocEvent<ExaminationEvent> event,
    Emitter<BlocState<PrimitiveViewData<int>>> emit,
  ) async {
    try {
      final argument = event.argument;
      return switch (argument) {
        UpdateCount() => _onUpdateCount(argument, emit),
        EditExamination() => _onEditExamination(argument, emit),
        ResetText() => _onResetText(argument, emit),
        DeleteExamination() => _onDeleteExamination(argument, emit),
      };
    } catch (e, st) {
      log('Error updating examination $event', error: e, stackTrace: st);
      emit(const BlocState.error());
    }
  }
}

sealed class ExaminationEvent extends Param {
  const ExaminationEvent({required this.examination});

  final Examination examination;

  @override
  List<Object?> get props => [examination];
}

class UpdateCount extends ExaminationEvent {
  const UpdateCount({required super.examination});
}

class EditExamination extends ExaminationEvent {
  const EditExamination({required super.examination});
}

class DeleteExamination extends ExaminationEvent {
  const DeleteExamination({required super.examination, this.undo = false});

  final bool undo;

  @override
  List<Object?> get props => [examination, undo];
}

class ResetText extends ExaminationEvent {
  const ResetText({required super.examination});
}
