import 'package:dio/dio.dart';
import 'package:lingoassignment/constants/k_url_end_points.dart';
import 'package:lingoassignment/remote_config.dart';
import 'package:lingoassignment/services/request.dart';

class NewsAPIs {
  static final NewsAPIs instance = NewsAPIs._();
  NewsAPIs._();

  Future<Response> getAllArticles() async {
    final dioService = DioService();
    String countryCode = await RemoteConfigService().fetchCountryCode();
    final response = await dioService.getRequest(
      api:
          "${BaseUrl.baseURL}v2/top-headlines?country=$countryCode&apiKey=ad567a0d440b4828a0fff9a397d1dd65",
      successStatusCode: [200],
    );
    return response;
  }
}
