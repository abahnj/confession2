import 'package:auto_route/auto_route.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';
import 'package:confession/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PrayerDetailsPage extends StatelessWidget {
  const PrayerDetailsPage({required this.prayer, super.key});

  final Prayer prayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConfessionAppBar(title: prayer.prayerName),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  prayer.text,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
