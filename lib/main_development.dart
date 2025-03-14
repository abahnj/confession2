import 'package:confession/bootstrap.dart';
import 'package:confession/error_reporting.dart';
import 'package:confession/firebase_options_development.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  bootstrap(
    // Change to true to test go_router implementation
    useGoRouter: false,
  ).then((_) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    configureErrorReporting();
  });
}