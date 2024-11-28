import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PrayerDetailsPage extends StatelessWidget {
  const PrayerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Text('Prayer Details Page'),
      ),
    );
  }
}
