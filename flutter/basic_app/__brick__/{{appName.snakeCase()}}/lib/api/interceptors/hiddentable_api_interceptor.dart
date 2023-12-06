import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HiddentableApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final idtoken = await FirebaseAuth.instance.currentUser?.getIdToken();
      // log(idtoken.toString());
      options.headers["accept"] = "application/json";
      options.headers["Authorization"] = "Bearer $idtoken";
    } catch (e) {
      log(e.toString());
    }
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    log(err.toString());
    return super.onError(err, handler);
  }
}
