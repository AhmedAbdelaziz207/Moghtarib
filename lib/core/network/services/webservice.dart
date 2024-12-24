import 'package:dio/dio.dart';
import 'package:mo3tarib/core/network/services/endpints.dart';

class Webservice {

  late final Dio _dio;
  late final LogInterceptor interceptor;

  Webservice() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ));
    interceptor = LogInterceptor(requestBody: true, responseBody: true);
    _dio.interceptors.add(interceptor);
  }


  Future<Response> createAccount(Map<String, dynamic> data){
    return _dio.post(registerEndpoint, data: data);
  }


  Future<Response> getDepartments(){
    return _dio.get(departmentEndpoint);
  }

}
