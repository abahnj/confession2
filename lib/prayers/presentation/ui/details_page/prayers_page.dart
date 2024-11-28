import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';
import 'package:confession/prayers/presentation/bloc/prayers_bloc.dart';
import 'package:confession/router/app_router.gr.dart';
import 'package:confession/shared/utils.dart';
import 'package:confession/shared/widgets/confession_list_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PrayersPage extends StatelessWidget {
  const PrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayersBloc(getPrayersUsecase: sl())..add(const BlocEvent.noParam()),
      child: const PrayersConsumer(),
    );
  }
}

class PrayersConsumer extends StatelessWidget {
  const PrayersConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final errorWidget = DisplayableErrorWidget(
              error: StateError('Unexpected state'),
              stackTrace: StackTrace.current,
              child: const PrayersErrorView(),
            );
    print('isDebug: $kDebugMode');
    print('shouldShowError: ${errorWidget.shouldShowError}');
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<PrayersBloc, BlocState<PrayerList>>(
          builder: (context, state) => state.mapOrElse(
            orElse: () => errorWidget ,
            // success: (prayers) => PrayersLoadedView(prayerList: prayers),
            //  error: () => const PrayersErrorView(),
          ),
        ),
      ),
    );
  }
}

class PrayersLoadedView extends StatelessWidget {
  const PrayersLoadedView({
    required this.prayerList,
    super.key,
  });

  final PrayerList prayerList;

  @override
  Widget build(BuildContext context) {
    const splitIndex = 7;

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'Act of Contrition',
          style: context.textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        ...prayerList.data.sublist(0, splitIndex).map(
              (prayer) => ConfessionListTile(
                title: prayer.prayerName,
                onTap: () {
                  context.pushRoute(const PrayerDetailsRoute());
                },
              ),
            ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Traditional Prayers',
            style: context.textTheme.headlineSmall,
          ),
        ),
        ...prayerList.data.sublist(splitIndex).map(
              (prayer) => ConfessionListTile(
                title: prayer.prayerName,
                onTap: () {
                  context.pushRoute(const PrayerDetailsRoute());
                },
              ),
            ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class PrayersErrorView extends StatelessWidget {
  const PrayersErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 200, width: 200, color: Colors.red);
  }
}

class PrayersLoadingView extends StatelessWidget {
  const PrayersLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class DisplayableErrorWidget extends StatelessWidget {
  const DisplayableErrorWidget({
    required this.child,
    super.key,
    this.error,
    this.stackTrace,
    this.enable = kDebugMode,
  });

  final Widget child;
  final Object? error;
  final StackTrace? stackTrace;
  final bool enable;

  @override
  Widget build(BuildContext context) => shouldShowError
      ? GestureDetector(
        onTap: () => showError(context),
          onLongPress: () {
            log('Error info: $info');
            showError(context);
          },
          child: child,
        )
      : child;

  bool get shouldShowError => enable && error != null || stackTrace != null;

  Future<void> showError(BuildContext context) async {
    await showDialog<void>(
      barrierColor: Theme.of(context).dialogTheme.barrierColor?.withOpacity(.5),
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Error info',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                error?.toString() ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              if (stackTrace != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    stackTrace.toString(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Copy'),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: info));

              debugPrint(info);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error info copied to clipboard'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  String get info => '$error${stackTrace != null ? '\n\n$stackTrace' : ''}';
}

class ErrorContent extends StatelessWidget {
  const ErrorContent({
    required this.onPressed,
    super.key,
    this.image,
    this.title,
    this.icon,
    this.subtitle,
    this.buttonText,
    this.error,
  });

  final Widget? image;
  final Widget? title;
  final Widget? icon;
  final Widget? subtitle;
  final VoidCallback? onPressed;
  final String? buttonText;

  /// Error that will be displayed in debug staging of the app
  final Object? error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final ctaLabel = buttonText ?? ('notifications.error.retry');

    return DisplayableErrorWidget(
      error: error,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Center(
                        child: image ??
                            const Icon(
                              Icons.error_outline,
                              size: 100,
                              color: Colors.red,
                            ),
                      ),
                    ),
                    DefaultTextStyle.merge(
                      textAlign: TextAlign.start,
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      child: title ??
                          const Text(
                            'notifications.error.title',
                          ),
                    ),
                    const SizedBox(height: 10),
                    DefaultTextStyle.merge(
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      child: subtitle ?? const Text('notifications.error.subTitle'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (onPressed != null)
            Footer(
              child: icon != null
                  ? ElevatedButton.icon(
                      key: const ValueKey('retryButtonKey'),
                      onPressed: onPressed,
                      icon: icon,
                      label: Text(ctaLabel),
                    )
                  : ElevatedButton(
                      key: const ValueKey('retryButtonKey'),
                      onPressed: onPressed,
                      child: Text(ctaLabel),
                    ),
            ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    required this.child,
    super.key,
    this.showElevation = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    this.backgroundColor,
  });

  final EdgeInsets padding;
  final Widget child;
  final bool showElevation;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.surface,
        boxShadow: [
          if (showElevation)
            BoxShadow(
              offset: const Offset(0, 2.75),
              blurRadius: 8,
              color: context.colorScheme.shadow.withOpacity(0.2),
            ),
        ],
      ),
      padding: padding,
      child: SafeArea(
        top: false,
        child: child,
      ),
    );
  }
}
