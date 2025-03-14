# Confession App Development Guide

## Commands
- Build: `flutter build [apk|ios] --flavor [development|staging|production]`
- Test: `flutter test` or `./fluttertest.sh` (runs with coverage)
- Single test: `flutter test test/path/to/test_file.dart`
- Lint: `flutter analyze`
- Generate code: `flutter pub run build_runner build --delete-conflicting-outputs`

## Code Style
- **Imports**: Dart imports first, packages second, relative imports last
- **Naming**: Classes: PascalCase, methods/variables: camelCase, files: snake_case
- **Architecture**: Clean Architecture with BLoC pattern, Repository pattern, UseCase pattern
- **Error Handling**: Custom exceptions, BlocState.error(), try-catch with specific handlers
- **Testing**: Group related tests, mock dependencies with Mocktail, test edge cases
- **Line Length**: Exception to 80-char limit (see analysis_options.yaml)
- **Documentation**: Not required for public members (public_member_api_docs: false)

## Tools
- State Management: flutter_bloc
- Navigation: auto_route
- Database: drift
- DI: get_it
- Analytics/Monitoring: Firebase suite