import 'package:confession/router/transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FadeTransitionPage', () {
    // testWidgets('applies fade transition', (WidgetTester tester) async {
    //   final navigatorKey = GlobalKey<NavigatorState>();

    //   // Create a widget with navigation
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       navigatorKey: navigatorKey,
    //       home: const Scaffold(
    //         body: Center(child: Text('Home Page')),
    //       ),
    //     ),
    //   );

    //   // Push our custom page
    //   navigatorKey.currentState!.push(
    //     PageRouteBuilder<dynamic>(
    //       pageBuilder: (context, animation, secondaryAnimation) {
    //         return const Scaffold(
    //           body: Center(child: Text('Test Page')),
    //         );
    //       },
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
    //           child: child,
    //         );
    //       },
    //     ),
    //   );

    //   // Ensure home page is displayed before transition
    //   expect(find.text('Home Page'), findsOneWidget);
    //   expect(find.text('Test Page'), findsNothing);

    //   // Start transition
    //   await tester.pump();
    //   expect(find.text('Home Page'), findsOneWidget);
    //   expect(find.text('Test Page'), findsOneWidget);

    //   // Halfway through transition
    //   await tester.pump(const Duration(milliseconds: 150));
    //   expect(find.text('Home Page'), findsOneWidget);
    //   expect(find.text('Test Page'), findsOneWidget);

    //   // Complete transition
    //   await tester.pumpAndSettle();
    //   expect(find.text('Home Page'), findsNothing);
    //   expect(find.text('Test Page'), findsOneWidget);
    // });

    test('has correct properties', () {
      const testWidget = Text('Test');
      const pageKey = ValueKey('page-key');
      const pageName = 'test-page';
      const arguments = {'test': 'value'};
      const restorationId = 'restore-id';

      final page = FadeTransitionPage<void>(
        child: testWidget,
        key: pageKey,
        name: pageName,
        arguments: arguments,
        restorationId: restorationId,
      );

      expect(page.child, testWidget);
      expect(page.key, pageKey);
      expect(page.name, pageName);
      expect(page.arguments, arguments);
      expect(page.restorationId, restorationId);
    });
  });
}
