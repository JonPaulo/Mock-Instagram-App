import 'dart:async';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sentry/sentry.dart' as Sentry;

import 'app.dart';

void main() async {
  Foundation.FlutterError.onError = (Foundation.FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
  runZoned(() {
    runApp(App());
  }, onError: (error, stackTrace) {
    reportError(error, stackTrace);
  });
}

Future<void> reportError(dynamic error, dynamic stackTrace) async {
  if (Foundation.kDebugMode) {
    print(stackTrace);
    return;
  }
  String dsn = await rootBundle.loadString('assets/sentry_dsn.txt');
  Sentry.SentryClient sentry = Sentry.SentryClient(dsn: dsn);

  final Sentry.SentryResponse response =
      await sentry.captureException(exception: error, stackTrace: stackTrace);
  if (response.isSuccessful) {
    print('Sentry ID: ${response.eventId}');
  } else {
    print('Failed to report to Sentry: ${response.error}');
  }
}
