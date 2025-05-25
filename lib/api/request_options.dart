import 'package:dio/dio.dart';

class RequestSettings extends RequestOptions {
  @override
  final headers = {
    'accept': 'application/json',
    'content-type': 'application/json'
  };

  RequestSettings({
    super.method,
    required super.path,
    super.data,
    super.queryParameters,
    super.headers,
  });
}
