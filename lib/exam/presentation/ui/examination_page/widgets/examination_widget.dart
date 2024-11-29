import 'dart:developer';
import 'dart:math' hide log;

import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/exam/domain/entities/commandment.dart';
import 'package:confession/exam/domain/entities/examination.dart';
import 'package:confession/exam/domain/usecases/get_examinations_usecase.dart';
import 'package:confession/exam/domain/usecases/update_examination_usecase.dart';
import 'package:confession/exam/presentation/bloc/examinations_bloc.dart';
import 'package:confession/exam/presentation/bloc/update_examination_bloc.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:confession/shared/widgets/confession_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuOptions { edit, delete, decrement, resetCount }

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
      padding: const EdgeInsets.all(8),
      child: FittedBox(
        child: Text(
          commandment.commandment,
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

  Future<MenuOptions?> _showPopupMenu(BuildContext context, LongPressStartDetails details) async {
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
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.decrement,
          child: Text('decrementText'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.edit,
          child: Text('editText'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.delete,
          child: Text('deleteText'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.resetCount,
          child: Text('resetText'),
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
          onTap: () => context.read<UpdateExaminationBloc>().add(
                BlocEvent(
                  argument: UpdateExaminationParam(
                    examination: examination.copyWith(count: examination.count + 1),
                  ),
                ),
              ),
          onLongPress: (details) async {
            final selected = await _showPopupMenu(context, details);
            if (context.mounted) {
              switch (selected) {
                case MenuOptions.decrement:
                  context.read<UpdateExaminationBloc>().add(
                        BlocEvent(
                          argument: UpdateExaminationParam(
                            examination: examination.copyWith(count: max(0, examination.count - 1)),
                          ),
                        ),
                      );
                case MenuOptions.edit:
                  log('Edit');
                case MenuOptions.delete:
                  log('Delete');
                case MenuOptions.resetCount:
                  context.read<UpdateExaminationBloc>().add(
                        BlocEvent(
                          argument: UpdateExaminationParam(
                            examination: examination.copyWith(count: 0),
                          ),
                        ),
                      );
                case _:
                  log('No action');
              }
            }
          },
        );
      },
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
