import 'package:flutter/material.dart';
import 'router/router.dart';

class AppConfig {
  static final _appRouter = AppRouter();
  static AppRouter get appRouter => _appRouter;
  static BuildContext get context => _appRouter.navigatorKey.currentContext!;

  static GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
