import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/core/errors/app_exception.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';
import 'package:confession/prayers/presentation/bloc/prayers_bloc.dart';
import 'package:confession/prayers/presentation/ui/details_page/prayer_details_page.dart';
import 'package:confession/router/nav_paths.dart';
import 'package:confession/shared/responsive/master_detail_controller.dart';
import 'package:confession/shared/responsive/master_detail_layout.dart';
import 'package:confession/shared/responsive/responsive_layout.dart';
import 'package:confession/shared/utils.dart';
import 'package:confession/shared/widgets/app_bar.dart';
import 'package:confession/shared/widgets/confession_list_tile.dart';
import 'package:confession/shared/widgets/error_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// A responsive prayers page that adapts to different screen sizes.
class ResponsivePrayersPage extends StatefulWidget {
  /// Creates a responsive prayers page.
  const ResponsivePrayersPage({
    this.selectedPrayer,
    this.selectedPrayerId,
    super.key,
  });

  /// The initially selected prayer.
  final Prayer? selectedPrayer;
  
  /// The ID of the prayer to select.
  /// This is used when navigating directly to a prayer via URL.
  final int? selectedPrayerId;

  @override
  State<ResponsivePrayersPage> createState() => _ResponsivePrayersPageState();
}

class _ResponsivePrayersPageState extends State<ResponsivePrayersPage> {
  late final MasterDetailController<Prayer> _controller;
  bool _didInitialLoad = false;

  @override
  void initState() {
    super.initState();
    _controller = MasterDetailController<Prayer>(
      selectedItem: widget.selectedPrayer,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterDetailControllerProvider<Prayer>(
      notifier: _controller,
      child: BlocProvider(
        create: (context) => PrayersBloc(getPrayersUsecase: sl())
          ..add(const BlocEvent.noParam()),
        child: BlocListener<PrayersBloc, BlocState<PrayerList>>(
          listener: (context, state) {
            if (state is Success<PrayerList> && 
                widget.selectedPrayerId != null && 
                widget.selectedPrayer == null &&
                !_didInitialLoad) {
              // Find prayer by ID from URL parameter
              final prayerList = state.data;
              // Only try to find the prayer if the list is not empty
              if (prayerList.data.isNotEmpty) {
                final prayer = prayerList.data.firstWhere(
                  (p) => p.id == widget.selectedPrayerId,
                  orElse: () => prayerList.data.first,
                );
                
                _controller.selectItem(prayer);
                _didInitialLoad = true;
              }
            }
          },
          child: const _ResponsivePrayersView(),
        ),
      ),
    );
  }
}

class _ResponsivePrayersView extends StatelessWidget {
  const _ResponsivePrayersView();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, layoutType) {
        final controller = MasterDetailControllerProvider.of<Prayer>(context);
        final displayMode = context.idealDisplayMode;

        // For compact layouts (phones), show only the master or detail
        if (displayMode == MasterDetailDisplayMode.masterOnly) {
          if (controller.selectedItem != null) {
            // If an item is selected, show the detail view
            return Scaffold(
              appBar: ConfessionAppBar(
                title: controller.selectedItem!.prayerName,
                leading: BackButton(
                  onPressed: () {
                    // Clear the selection
                    controller.clearSelection();
                    // Update URL to remove the prayer ID
                    context.go(NavPath.prayers.path);
                  },
                ),
              ),
              body: PrayerDetailsPage(prayer: controller.selectedItem!),
            );
          } else {
            // Otherwise, show the master list
            return const Scaffold(
              appBar: ConfessionAppBar(),
              body: _PrayersList(),
            );
          }
        } else {
          // For larger screens, show the master-detail layout
          return MasterDetailLayout(
            displayMode: displayMode,
            appBar: const ConfessionAppBar(title: 'Prayers'),
            masterBuilder: (context) => const _PrayersList(),
            detailBuilder: (context) {
              final selectedPrayer = controller.selectedItem;

              if (selectedPrayer != null) {
                return PrayerDetailsPage(prayer: selectedPrayer);
              } else {
                // Show a placeholder when no prayer is selected
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 48,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Select a prayer to view its details',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      if (context.mightBeFoldable) ...[
                        const SizedBox(height: 24),
                        Text(
                          'You can fold your device to use it in book mode',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}

class _PrayersList extends StatelessWidget {
  const _PrayersList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<PrayersBloc, BlocState<PrayerList>>(
        builder: (context, state) => state.mapOrElse(
          orElse: () => const Center(child: CircularProgressIndicator()),
          success: (prayers) => _PrayersListContent(prayerList: prayers),
          error: () => Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ErrorDisplay(
                exception: const FeatureException(
                  message: 'Failed to load prayers',
                  featureCode: 'PRAYERS',
                ),
                onRetry: () {
                  context.read<PrayersBloc>().add(const BlocEvent.noParam());
                },
                displayType: ErrorDisplayType.page,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrayersListContent extends StatelessWidget {
  const _PrayersListContent({
    required this.prayerList,
  });

  final PrayerList prayerList;

  @override
  Widget build(BuildContext context) {
    const splitIndex = 7;
    final controller = MasterDetailControllerProvider.of<Prayer>(context);

    // Helper function to handle prayer selection
    void selectPrayer(Prayer prayer) {
      // Update the controller state
      controller.selectItem(prayer);
      
      // Update the URL to reflect the selected prayer
      // This provides deep linking and browser history
      context.go(NavPath.prayerDetailsPath(prayer.id));
    }

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
                selected: controller.selectedItem?.id == prayer.id,
                onTap: () => selectPrayer(prayer),
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
                selected: controller.selectedItem?.id == prayer.id,
                onTap: () => selectPrayer(prayer),
              ),
            ),
        const SizedBox(height: 16),
      ],
    );
  }
}
