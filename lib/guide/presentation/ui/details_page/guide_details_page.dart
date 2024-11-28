import 'package:auto_route/auto_route.dart';
import 'package:confession/guide/domain/entities/guide.dart';
import 'package:confession/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GuideDetailsPage extends StatelessWidget {
  const GuideDetailsPage({required this.guide, super.key});

  final Guide guide;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: ConfessionAppBar(title: guide.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Card.filled(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  guide.text,
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
