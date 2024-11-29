import 'package:auto_route/auto_route.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/guide/domain/entities/guide.dart';
import 'package:confession/guide/presentation/bloc/guides_bloc.dart';
import 'package:confession/guide/usecases/get_guides_usecase.dart';
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
      create: (context) => GuidesBloc(getGuidesUsecase: sl())
        ..add(BlocEvent(argument: GuideParam(id: guideId))),
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
      appBar: const ConfessionAppBar(),
      body: ListView.builder(
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
    );
  }
}
