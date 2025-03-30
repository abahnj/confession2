import 'package:confession/core/errors/app_exception.dart';
import 'package:confession/shared/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Widget to display error messages in different contexts
class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    required this.exception,
    this.onRetry,
    this.displayType = ErrorDisplayType.snackbar,
    super.key,
  });

  /// The exception to display
  final AppException exception;
  
  /// Optional retry callback
  final VoidCallback? onRetry;
  
  /// How the error should be displayed
  final ErrorDisplayType displayType;

  @override
  Widget build(BuildContext context) {
    return switch (displayType) {
      ErrorDisplayType.inline => _buildInlineError(context),
      ErrorDisplayType.dialog => _buildDialogContent(context),
      ErrorDisplayType.snackbar => _buildSnackbarContent(context),
      ErrorDisplayType.page => _buildPageError(context),
    };
  }

  /// Build an inline error display
  Widget _buildInlineError(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: context.colorScheme.onErrorContainer,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  exception.userMessage,
                  style: TextStyle(
                    color: context.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  foregroundColor: context.colorScheme.onErrorContainer,
                ),
                child: const Text('Retry'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Build dialog content
  Widget _buildDialogContent(BuildContext context) {
    final isNetwork = exception is NetworkException;
    final isAuth = exception is AuthException;
    
    final icon = isNetwork
        ? Icons.wifi_off
        : isAuth
            ? Icons.lock
            : Icons.error_outline;
            
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 48,
          color: context.colorScheme.error,
        ),
        const SizedBox(height: 16),
        Text(
          exception.userMessage,
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium,
        ),
        if (kDebugMode) ...[
          const SizedBox(height: 8),
          Text(
            exception.toString(),
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        if (onRetry != null) ...[
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ],
    );
  }

  /// Build snackbar content
  Widget _buildSnackbarContent(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.error_outline,
          color: context.colorScheme.onError,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            exception.userMessage,
            style: TextStyle(color: context.colorScheme.onError),
          ),
        ),
        if (onRetry != null)
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              foregroundColor: context.colorScheme.onError,
            ),
            child: const Text('Retry'),
          ),
      ],
    );
  }

  /// Build full page error
  Widget _buildPageError(BuildContext context) {
    final isNetwork = exception is NetworkException;
    final isAuth = exception is AuthException;
    
    final icon = isNetwork
        ? Icons.wifi_off
        : isAuth
            ? Icons.lock
            : Icons.error_outline;
            
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: 24),
            Text(
              exception.userMessage,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              _getDetailedMessage(),
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getDetailedMessage() {
    if (exception is NetworkException) {
      final networkException = exception as NetworkException;
      return networkException.isConnectionError
          ? 'Check your internet connection and try again.'
          : 'There was a problem connecting to our servers. Please try again later.';
    } else if (exception is DatabaseException) {
      return 'A problem occurred with the app data. Try restarting the app.';
    } else if (exception is AuthException) {
      return 'You may need to sign in again to continue.';
    }
    return 'Something went wrong. Please try again.';
  }

  /// Show a dialog with this error
  static Future<void> showErrorDialog(
    BuildContext context,
    AppException exception, {
    VoidCallback? onRetry,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: ErrorDisplay(
          exception: exception,
          onRetry: onRetry,
          displayType: ErrorDisplayType.dialog,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Show a snackbar with this error
  static void showErrorSnackBar(
    BuildContext context,
    AppException exception, {
    VoidCallback? onRetry,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colorScheme.error,
        content: ErrorDisplay(
          exception: exception,
          onRetry: onRetry,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}

/// Different ways to display an error
enum ErrorDisplayType {
  /// Display as inline widget
  inline,
  
  /// Display in a dialog
  dialog,
  
  /// Display in a snackbar
  snackbar,
  
  /// Display as a full page
  page,
}
