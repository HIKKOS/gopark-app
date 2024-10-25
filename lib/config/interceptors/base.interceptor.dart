import 'package:dio/dio.dart';

class BaseInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final params = <String, dynamic>{};
    options.baseUrl = 'baseUrl';
    options.queryParameters = params;
    options.sendTimeout = const Duration(seconds: 4);
    super.onRequest(options, handler);
  }
}
