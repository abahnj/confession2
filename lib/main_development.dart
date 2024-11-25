import 'package:confession/app/app.dart';
import 'package:confession/bootstrap.dart';
import 'package:confession/error_reporting.dart';
import 'package:confession/firebase_options_development.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  bootstrap(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    configureErrorReporting();

    return const App();
  });
}
