import 'request_options.dart';

class APIRoute {
  final RequestSettings settings;
  late final String method;
  APIRoute(this.settings, this.method);

  APIRoute.get(this.settings) {
    method = API.get.method;
    settings.method = API.get.method;
  }
  APIRoute.post(this.settings) {
    method = API.post.method;
    settings.method = API.post.method;
  }
}

enum API {
  get,
  post,
  put,
  delete,
  patch;

  String get method => name.toUpperCase();
}
