import 'package:bloc/bloc.dart';
import 'package:confession/core/errors/app_exception.dart';
import 'package:confession/core/errors/bloc_error_observer.dart';
import 'package:confession/core/errors/error_handler.dart';
import 'package:confession/shared/widgets/error_display.dart';
import 'package:flutter/material.dart';

/// Configure all error reporting systems
void configureErrorReporting() {
  // Initialize the error handler
  ErrorHandler.instance.initialize();
  
  // Set bloc observer
  Bloc.observer = const AppBlocObserver();
  
  // Add any additional error reporting setup here
}

/// Widget that provides error handling capabilities to its descendants
class ErrorHandlerProvider extends StatefulWidget {
  const ErrorHandlerProvider({required this.child, super.key});

  final Widget child;

  @override
  State<ErrorHandlerProvider> createState() => _ErrorHandlerProviderState();
}

class _ErrorHandlerProviderState extends State<ErrorHandlerProvider> implements ErrorListener {
  @override
  void initState() {
    super.initState();
    ErrorHandler.instance.addListener(this);
  }

  @override
  void dispose() {
    ErrorHandler.instance.removeListener(this);
    super.dispose();
  }

  @override
  void onError(AppException exception) {
    if (mounted && exception.shouldDisplay) {
      _showErrorDisplay(exception);
    }
  }

  void _showErrorDisplay(AppException exception) {
    // Use appropriate display method based on exception type
    final isNetwork = exception is NetworkException;
    final isAuth = exception is AuthException;
    
    if (isNetwork || isAuth) {
      ErrorDisplay.showErrorDialog(context, exception);
    } else {
      ErrorDisplay.showErrorSnackBar(context, exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
