import 'package:flutter/material.dart';

extension UIExtension on BuildContext {
  Future<void> showLoading() async {
    return showDialog(
        context: this,
        barrierDismissible: true,
        barrierColor: Colors.transparent.withOpacity(.2),
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(true),
            child: AlertDialog(
              content: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(this).primaryColor,
                      strokeWidth: 8,
                    ),
                    const Text('Loading data...')
                  ],
                )),
              ),
            ),
          );
        });
  }

  Future<void> showErrorMessage(String error, {int? duration}) async {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(error),
        duration: duration == null
            ? const Duration(seconds: 3)
            : Duration(seconds: duration),
      ));
  }

  Future<void> showSuccessMessage(String message, {int? duration}) async {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        duration: duration == null
            ? const Duration(seconds: 3)
            : Duration(seconds: duration),
      ));
  }

  Future<void> showErrorRetry(
    String message, {
    int? duration,
    required VoidCallback onRetry,
  }) async {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(message)),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            )
          ],
        ),
        duration: duration == null
            ? const Duration(hours: 10)
            : Duration(seconds: duration),
      ));
  }
}
