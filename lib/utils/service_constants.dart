import 'package:dio/dio.dart';

class ServiceVariables {
  static List<Interceptor> interceptors = [
    /* AwesomeDioInterceptor(
      // Disabling headers and timeout would minimize the logging output.
      // Optional, defaults to true
      logRequestTimeout: false,
      logRequestHeaders: true,
      logResponseHeaders: false,

      // Optional, defaults to the 'log' function in the 'dart:developer' package.
      logger: debugPrint,
    ), */
  ];
}

class Endpoints {
  static const yesOrNo = '';
}
