import 'package:dio/dio.dart';
import 'package:gopark/config/interceptors/base.interceptor.dart';
import 'package:gopark/data/models/parking_response.dart';

class UserAuthHttp {
  static final _dioAuth = Dio()..interceptors.add(BaseInterceptor());

  Future<ParkingResponse> login(String qrCajon) async {
    final body = {
      'qr_cajon': qrCajon,
    };
    final response = await _dioAuth.post(
      '/login',
      data: body,
    );
    final data = ParkingResponse.fromJson(response.data);
    return data;
  }
}
