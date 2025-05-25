import '../api/api_response.dart';
import '../api/api_route.dart';
import '../api/decodable.dart';
import '../utils/service_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService implements BaseAPIClient {
  late Dio _dio;
  final baseOptions = BaseOptions(
    baseUrl: ServiceVariables.kBaseUrl,
    queryParameters: {},
  );

  ApiService() {
    _dio = Dio(baseOptions);
    _dio.interceptors.addAll(ServiceVariables.interceptors);
  }

  dynamic templateConverter(Map<String, dynamic> data) {
    final keyCheckList = ["data", "error"];
    if (!data.keys.any((key) => keyCheckList.contains(key))) {
      try {
        throw ErrorResponse(
            message: "Response Modelin 'data' ve 'error' keyleri bulunamadı.");
      } catch (e) {
        return {"data": data, "error": null, "status": "success"};
      }
    }
    return data;
  }

  @override
  Future<ResponseWrapper<T>> request<T extends Decodable>({
    required APIRoute route,
    required Create<T> create,
    dynamic data,
  }) async {
    final config = route.settings;
    config.baseUrl = baseOptions.baseUrl;
    if (data != null) {
      if (config.method == API.get.method) {
        config.queryParameters = data;
      } else {
        config.data = data;
      }
    }
    try {
      final response = await _dio.fetch(config);
      dynamic data = response.data;
      if (response.statusCode == 200) {
        data = templateConverter(data);
      }
      return ResponseWrapper.init(create: create, data: data);
    } on DioException catch (err) {
      throw ErrorResponse(message: err.message);
    }
  }
}

abstract class BaseAPIClient {
  Future<ResponseWrapper<T>> request<T extends Decodable>({
    required APIRoute route,
    required Create<T> create,
    dynamic data,
  });
}
