import 'package:dio/dio.dart';
import 'package:gopark/config/interceptors/base.interceptor.dart';
import 'package:gopark/data/models/cajon_response.dart';

class CajonInfoHttp {
  static final _dioAuth = Dio()..interceptors.add(BaseInterceptor());

  Future<CajonResponse> getInfo(int cajonid) async {
    final response = await _dioAuth.get(
      "/$cajonid",
    );

    final data = CajonResponse.fromJson(response.data);
    return data;
  }
}
