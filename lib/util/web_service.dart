import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

class CustomRetryInterceptor extends Interceptor {
  final Dio dio;

  CustomRetryInterceptor(this.dio);

  @override
  Future onError(DioError error) async {
    print("we have an error, code is ${error.response.statusCode}");
    dio.get(
      error.request.uri.toString(),
      queryParameters: error.request.queryParameters,
    );
  }
}

abstract class WebService {
  Future<dynamic> get(String url, {Map<String, dynamic> parameters});
}

class WebServiceImpl implements WebService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://us-central1-mynextbase-connect.cloudfunctions.net/",
    ),
  )..interceptors.add(
      LogInterceptor(),
    );

  final _retryOptions = RetryOptions(
    delayFactor: const Duration(milliseconds: 20),
    maxAttempts: 10,
  );

  @override
  Future<dynamic> get(String url, {Map<String, dynamic> parameters}) async {
    final Response response = await _retryOptions.retry(
      () => _dio.get(url, queryParameters: parameters),
      retryIf: (Exception e) => e is DioError && e.response.statusCode == 500,
    );
    return response.data;
  }
}
