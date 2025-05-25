import '../api/interceptors/custom_interceptor.dart';
import 'package:dio/dio.dart';

class ServiceVariables {
  static const kBaseUrl = "https://yesno.wtf/api";
  static List<Interceptor> interceptors = [
    CustomInterceptor(),
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
