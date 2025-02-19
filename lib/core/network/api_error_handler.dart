import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return ApiErrorModel(message:  "Request canceled");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "Connection timeout");
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(message: "Send timeout");
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: "Receive timeout");
        case DioExceptionType.badCertificate:
          return ApiErrorModel(message: "Bad certificate");
        case DioExceptionType.badResponse:
          return handleError(error.response!);
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: "Connection error");
        case DioExceptionType.unknown:
          return ApiErrorModel(message: "Unknown error");
      }
    } else {
      return ApiErrorModel(message: "Unknown error");
    }
  }

  static ApiErrorModel handleError(Response response) {
    try {
      final Map<String, dynamic> data = response.data;
      return ApiErrorModel(
        message: data['message'],
        statusCode: data['statusCode'],
        errors: data['errors'],
      );
    } catch (e) {
      return ApiErrorModel(message: "Unknown error");
    }
  }


}