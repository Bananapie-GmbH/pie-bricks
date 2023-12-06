import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:hiddentable/api/hiddentable_api.dart';
import 'package:hiddentable/api/interceptors/hiddentable_api_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:hiddentable/utils/env.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  ApiService._();
  static final instance = ApiService._();
  late HiddentableApi _api;

  Future<void> initialize() async {
    _api = HiddentableApi(
      Dio()..interceptors.add(HiddentableApiInterceptor()),
      baseUrl: Env.baseUrl,
    );
  }

  factory ApiService() {
    return instance;
  }
}

HiddentableApi useApi() {
  return ApiService()._api;
}
