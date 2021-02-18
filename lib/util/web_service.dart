import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

abstract class WebService {
  Future<dynamic> get(String url, {Map<String, dynamic> parameters});
}

class WebServiceImpl implements WebService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://us-central1-mynextbase-connect.cloudfunctions.net/",
    ),
  )..interceptors.add(LogInterceptor(responseBody: true));

  final _retryOptions = RetryOptions();

  @override
  Future<dynamic> get(String url, {Map<String, dynamic> parameters}) async {
    final Response response = await _retryOptions.retry(
      () => _dio.get(url, queryParameters: parameters),
      retryIf: (Exception e) => e is DioError && e.response.statusCode == 500,
    );
    return response.data;
  }
}
