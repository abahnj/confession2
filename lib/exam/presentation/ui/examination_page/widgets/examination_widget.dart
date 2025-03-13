import 'dart:developer';
import 'dart:math' hide log;

import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/exam/domain/entities/commandment.dart';
import 'package:confession/exam/domain/entities/examination.dart';
import 'package:confession/exam/domain/usecases/get_examinations_usecase.dart';
import 'package:confession/exam/presentation/bloc/examinations_bloc.dart';
import 'package:confession/exam/presentation/bloc/update_examination_bloc.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:confession/shared/utils.dart';
import 'package:confession/shared/widgets/confession_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuOptions { edit, delete, decrement, resetCount, resetText }

class KeepAliveExaminationPage extends StatefulWidget {
  const KeepAliveExaminationPage({
    required this.commandment,
    super.key,
  });

  final Commandment commandment;

  @override
  State<KeepAliveExaminationPage> createState() => _KeepAliveExaminationPageState();
}

class _KeepAliveExaminationPageState extends State<KeepAliveExaminationPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) => ExaminationsBloc(getExaminationsUsecase: sl())
        ..add(
          BlocEvent(
            argument: GetExaminationsParam(
              commandmentId: widget.commandment.id,
              user: context.read<UserBloc>().state,
            ),
          ),
        ),
      child: Column(
        children: [
          CommandmentHeader(commandment: widget.commandment),
          Expanded(
            child: BlocBuilder<ExaminationsBloc, BlocState<ExaminationsList>>(
              builder: (context, state) => state.mapOrElse(
                orElse: () => const ExaminationsLoadingView(),
                success: (examinations) => ExaminationList(examinationsList: examinations),
                error: () => const ExaminationsErrorView(),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class CommandmentHeader extends StatelessWidget {
  const CommandmentHeader({
    required this.commandment,
    super.key,
  });

  final Commandment commandment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FittedBox(
        child: Text(
          commandment.commandmentText.isNotEmpty ? commandment.commandmentText : commandment.commandment,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

class ExaminationList extends StatelessWidget {
  const ExaminationList({
    required this.examinationsList,
    super.key,
  });

  final ExaminationsList examinationsList;

  Future<void> _showDeletedSnackbar({
    required BuildContext context,
    required String message,
    required Examination examination,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: context.l10n.snackbarActionUndo,
          backgroundColor: context.colorScheme.secondary,
          onPressed: () {
            context.read<UpdateExaminationBloc>().add(
                  BlocEvent(
                    argument: DeleteExamination(examination: examination, undo: true),
                  ),
                );
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> _handleMenuSelection(
    BuildContext context,
    MenuOptions? selected,
    Examination examination,
  ) async {
    if (!context.mounted) return;

    final bloc = context.read<UpdateExaminationBloc>();

    if (selected == null) return;

    switch (selected) {
      case MenuOptions.decrement:
        bloc.add(
          BlocEvent(
            argument: UpdateCount(
              examination: examination.copyWith(
                count: max(0, examination.count - 1),
              ),
            ),
          ),
        );
      case MenuOptions.edit:
        await _showEditDialog(context, examination);
      case MenuOptions.delete:
        await _showDeleteConfirmation(context, examination);
      case MenuOptions.resetCount:
        bloc.add(
          BlocEvent(
            argument: UpdateCount(examination: examination.copyWith(count: 0)),
          ),
        );
      case MenuOptions.resetText:
        bloc.add(
          BlocEvent(
            argument: ResetText(examination: examination),
          ),
        );
    }
  }

  Future<void> _showEditDialog(
    BuildContext context,
    Examination examination,
  ) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const EditExaminationDialog(),
    );

    if (result != null && context.mounted && result != examination.examinationText) {
      context.read<UpdateExaminationBloc>().add(
            BlocEvent(
              argument: EditExamination(
                examination: examination.copyWith(examinationText: result),
              ),
            ),
          );
    }
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    Examination examination,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.examinationPopupMenuDeleteConfirmationTitle),
        content: Text(context.l10n.examinationPopupMenuDeleteConfirmationContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.confirmationActionNo),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.confirmationActionYes),
          ),
        ],
      ),
    );

    if ((confirmed ?? false) && context.mounted) {
      log('Deleting examination: $examination');

      context.read<UpdateExaminationBloc>().add(
            BlocEvent(
              argument: DeleteExamination(examination: examination),
            ),
          );

      await _showDeletedSnackbar(
        context: context,
        message: context.l10n.examinationPopupMenuDeleteConfirmationSnackbar,
        examination: examination,
      );
    }
  }

  Future<MenuOptions?> _showPopupMenu({
    required BuildContext context,
    required LongPressStartDetails details,
    required bool isCustom,
  }) async {
    final overlay = Overlay.of(context).context.findRenderObject()! as RenderBox;

    return showMenu<MenuOptions?>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        overlay.size.width - details.globalPosition.dx,
        overlay.size.height - details.globalPosition.dy,
      ),
      items: <PopupMenuEntry<MenuOptions>>[
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.decrement,
          child: ListTile(
            title: Text(context.l10n.examinationPopupMenuDecrement),
            leading: const Icon(Icons.remove),
          ),
        ),
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.edit,
          child: ListTile(
            title: Text(context.l10n.examinationPopupMenuEdit),
            leading: const Icon(Icons.edit),
          ),
        ),
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.resetCount,
          child: ListTile(
            title: Text(context.l10n.examinationPopupMenuResetCount),
            leading: const Icon(Icons.refresh),
          ),
        ),
        if (isCustom)
          PopupMenuItem<MenuOptions>(
            value: MenuOptions.resetText,
            child: ListTile(
              title: Text(context.l10n.examinationPopupMenuResetText),
              leading: const Icon(Icons.refresh),
            ),
          ),
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.delete,
          child: ListTile(
            title: Text(context.l10n.examinationPopupMenuDelete),
            leading: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: examinationsList.data.length,
      itemBuilder: (context, index) {
        final examination = examinationsList.data[index];
        return ConfessionListTile(
          title: examination.examinationText,
          trailing: Text(
            examination.count.toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          isCustom: examination.isCustom,
          onTap: () => context.read<UpdateExaminationBloc>().add(
                BlocEvent(
                  argument: UpdateCount(
                    examination: examination.copyWith(count: examination.count + 1),
                  ),
                ),
              ),
          onLongPress: (details) async {
            final selected = await _showPopupMenu(
              context: context,
              details: details,
              isCustom: examination.isCustom,
            );
            if (context.mounted) {
              await _handleMenuSelection(context, selected, examination);
            }
          },
        );
      },
    );
  }
}

class EditExaminationDialog extends StatefulWidget {
  const EditExaminationDialog({
    super.key,
  });

  @override
  State<EditExaminationDialog> createState() => _EditExaminationDialogState();
}

class _EditExaminationDialogState extends State<EditExaminationDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.examinationPopupMenuEdit),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: context.l10n.examinationPopupMenuEditLabel,
          hintText: context.l10n.examinationPopupMenuEditHint,
        ),
        maxLines: null,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.l10n.examinationPopupMenuEditCancel,
            style: TextStyle(color: context.colorScheme.onSurfaceVariant),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: Text(context.l10n.examinationPopupMenuEditSave),
        ),
      ],
    );
  }
}

class ExaminationsLoadingView extends StatelessWidget {
  const ExaminationsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ExaminationsErrorView extends StatelessWidget {
  const ExaminationsErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error loading examinations'),
    );
  }
}
