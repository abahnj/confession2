import 'package:auto_route/auto_route.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/guide/domain/entities/guide.dart';
import 'package:confession/guide/presentation/bloc/guides_bloc.dart';
import 'package:confession/guide/usecases/get_guides_usecase.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/router/app_router.gr.dart';
import 'package:confession/shared/widgets/app_bar.dart';
import 'package:confession/shared/widgets/confession_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GuideDetailListPage extends StatelessWidget {
  const GuideDetailListPage({
    @PathParam('guideId') required this.guideId,
    super.key,
  });

  final int guideId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuidesBloc(getGuidesUsecase: sl())..add(BlocEvent(argument: GuideParam(id: guideId))),
      child: const GuideDetailListConsumer(),
    );
  }
}

class GuideDetailListConsumer extends StatelessWidget {
  const GuideDetailListConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuidesBloc, BlocState<GuideList>>(
      builder: (context, state) => state.mapOrElse(
        orElse: () => const GuideDetailListLoading(),
        error: () => const GuideDetailListError(),
        success: (guideList) => GuideDetailListSuccess(guideList: guideList),
      ),
    );
  }
}

class GuideDetailListLoading extends StatelessWidget {
  const GuideDetailListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class GuideDetailListError extends StatelessWidget {
  const GuideDetailListError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error'),
    );
  }
}

class GuideDetailListSuccess extends StatelessWidget {
  const GuideDetailListSuccess({
    required this.guideList,
    super.key,
  });

  final GuideList guideList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConfessionAppBar(title: context.l10n.guidesNavbarTitle),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: FittedBox(
              child: Text(
                _getGuideTitle(
                  context.topRoute.params.getInt('guideId', 0),
                ),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: guideList.data.length,
              itemBuilder: (context, index) {
                final guide = guideList.data[index];
                return ConfessionListTile(
                  title: guide.title,
                  onTap: () {
                    context.router.push(GuideDetailsRoute(guide: guide));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getGuideTitle(int guideId) {
    return switch (guideId) {
      1 => 'Catholic Confession - FAQ',
      2 => 'Popes on Confession',
      3 => 'Frequenct Confession - Fulton Sheen',
      4 => 'Cathechism of the Catholic Church',
      5 => 'How to make a good confession',
      _ => 'Unknown',
    };
  }
}
