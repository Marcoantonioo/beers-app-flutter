import 'package:beers_app/core/http/http_remote.dart';
import 'package:beers_app/core/http/request.dart';
import 'package:dio/dio.dart';

class HttpRemoteImpl extends HttpRemote {
  final Dio _dio = Dio();

  HttpRemoteImpl({
    required String? baseUrl,
  }) : assert(baseUrl != null) {
    _dio.options.baseUrl = baseUrl!;
  }

  @override
  Future<List> doRequest(RequestModel request) async {
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
          'STATUS => ${response.statusCode}\n'
          'TIME => $requestTime\n'
          'RESPONSE => ${response.data}');

      return response.data as List<dynamic>;
    } on DioError catch (error, _) {
      return error.response?.data as List<dynamic>;
    }
  }
}
