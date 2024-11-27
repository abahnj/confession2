import 'package:auto_route/auto_route.dart';
import 'package:confession/router/app_router.gr.dart';
import 'package:confession/shared/widgets/confession_list_tile.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PrayersPage extends StatelessWidget {
  const PrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ConfessionListTile(
            title: 'Our Father',
            onTap: () {
              context.router.push(const PrayerDetailsRoute());
            },
          ),
        ],
      ),
    );
  }
}
