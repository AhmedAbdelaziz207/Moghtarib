import 'package:dio/dio.dart';

String getErrorMessage(DioException e) {
  if (e.response != null) {
    if (e.response?.data != null) {
      try {
        final data = e.response?.data;
        // If the response is a map with keys like "ahmed_2020@gmail.com"
        if (data is Map<String, dynamic>) {
          return data.entries
              .map((entry) =>
          '${entry.key}: ${entry.value is List ? (entry.value as List).join(", ") : entry.value}')
              .join("\n");
        }
        // Handle other cases like "errors" or "message"
        if (data['errors'] is List) {
          return (data['errors'] as List).join(', ');
        }
        return data['message'] ?? 'Unknown error occurred';
      } catch (error) {
        return 'Error parsing response';
      }
    } else {
      return 'Received invalid status code: ${e.response?.statusCode}';
    }
  } else {
    return e.message!.contains('SocketException')
        ? 'No internet connection'
        : 'Request failed: ${e.message}';
  }
}
