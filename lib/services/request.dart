import 'package:dio/dio.dart';
import 'package:lingoassignment/constants/k_url_end_points.dart';

class DioService {
  final Dio _dio;
  final Dio dioBase = Dio();

  DioService({Map<String, dynamic>? headers})
      : _dio = Dio(BaseOptions(
            validateStatus: (status) {
              return (status ?? 0) < 500;
            },
            headers: headers,
            baseUrl: BaseUrl.baseURL));

  Future<Response> getRequest({
    required String api,
    required List<int> successStatusCode,
  }) async {
    try {
      final response = await _dio.get(
        api,
      );
      return _handleResponse(response, successStatusCode);
    } catch (e) {
      return _handleError(e);
    }
  }

  Response _handleResponse(Response response, List<int> successStatusCode) {
    if (successStatusCode.contains(response.statusCode)) {
      return response;
    } else {
      return Response(
          statusCode: response.statusCode,
          data: response.data,
          requestOptions: response.requestOptions);
    }
  }

  Response _handleError(dynamic error) {
    return Response(
        data: {},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
        headers: Headers(),
        statusMessage: error.toString());
  }
}
