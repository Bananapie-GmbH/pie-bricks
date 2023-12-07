import 'package:dio/dio.dart';

import '../api/api.dart';
import '../api/interceptors/api_interceptor.dart';
import '../utils/env.dart';

class ApiService {
  ApiService._();
  static final instance = ApiService._();
  late Api _api;

  Future<void> initialize() async {
    _api = Api(
      Dio()..interceptors.add(ApiInterceptor()),
      baseUrl: Env.baseUrl,
    );
  }

  factory ApiService() {
    return instance;
  }
}

Api useApi() {
  return ApiService()._api;
}
