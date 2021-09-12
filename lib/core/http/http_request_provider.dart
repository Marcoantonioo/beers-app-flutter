import 'package:app_miles/app_miles.dart';
import 'package:app_miles/core/http/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class HttpRequestProvider extends HttpRemote {
  final Dio _dio = Dio();
  final SessionRepository? _sessionRepository;
  HttpRequestProvider(
      {@required String? baseUrl,
      @required SessionRepository? sessionRepository})
      : _sessionRepository = sessionRepository,
        assert(baseUrl != null),
        assert(sessionRepository != null) {
    _dio.options.baseUrl = baseUrl!;

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
    ));
  }

  @override
  Future<Map<String, dynamic>> doRequest(RequestModel request) async {
    Dio http = _dio;

    try {
      DateTime requestInit = DateTime.now();

      Response<dynamic> response = await http.request<dynamic>(
        request.endpoint!,
        data: request.params,
        queryParameters: request.queryParameters,
        options: Options(
          method: request.getMethodString(),
          sendTimeout: http.options.sendTimeout,
        ),
      );

      DateTime requestDone = DateTime.now();

      final requestTime = requestDone.difference(requestInit).inMilliseconds;

      print('ENDPOINT => ${request.endpoint}\n'
          'METHOD => ${request.getMethodString()}\n'
          'STATUS => ${response.data['status']}\n'
          'TIME => $requestTime');

      return response.data as Map<String, dynamic>;
    } on DioError catch (error, _) {
      return error.response?.data as Map<String, dynamic>;
    }
  }

  dynamic Function(RequestOptions, RequestInterceptorHandler) get _onRequest =>
      (RequestOptions requestOptions, RequestInterceptorHandler handler) async {
        await _sessionRepository?.getSession().then((session) {
          final token = session?.jwt?.token;

          if (session != null || token != null && token.isNotEmpty) {
            requestOptions.headers['Authorization'] = 'Bearer $token';
          }
        });
        return requestOptions;
      };
}
