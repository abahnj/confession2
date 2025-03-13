import 'package:auto_route/auto_route.dart';
import 'package:confession/shared/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

enum FeedbackType { bug, feature, other }

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  late final FirebaseAnalytics analytics;
  late final TextEditingController feedbackController;

  @override
  void initState() {
    super.initState();
    analytics = FirebaseAnalytics.instance;
    feedbackController = TextEditingController();
  }

  FeedbackType feedbackType = FeedbackType.bug;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          'Feedback',
          // style: context.textTheme.titleLarge,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Wrap(
              children: <Widget>[
                RadioListTile<FeedbackType>(
                  title: const Text('Bug'),
                  value: FeedbackType.bug,
                  groupValue: feedbackType,
                  onChanged: (value) {
                    setState(() {
                      feedbackType = FeedbackType.bug;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Feature'),
                  value: FeedbackType.feature,
                  groupValue: feedbackType,
                  onChanged: (value) {
                    setState(() {
                      feedbackType = FeedbackType.feature;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Other'),
                  value: FeedbackType.other,
                  groupValue: feedbackType,
                  onChanged: (value) {
                    setState(() {
                      feedbackType = FeedbackType.other;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              decoration: const InputDecoration(
                hintText: 'Enter your feedback',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final deviceInfo = await getDeviceInfo();
            await analytics.logEvent(
              name: 'feedback_submitted',
              parameters: {
                'device': deviceInfo,
                'feedback': feedbackController.text,
              },
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feedback submitted'),
                  duration: Duration(seconds: 2),
                ),
              );
              await context.maybePop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
