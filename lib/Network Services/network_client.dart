import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:themovieflex/Network%20Services/api_params.dart';

import '../Widget/constant.dart';

class NetworkClient extends GetxController {
  Dio _dio = Dio();
  String baseURL = "https://api.themoviedb.org/3/movie/";

  NetworkClient() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseURL,
      maxRedirects: 2,
      responseType: ResponseType.json,
    );
    _dio = Dio(baseOptions);
    // adding logging interceptor.
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      error: true,
      request: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  Future<Response> get(
      {required String url,
      Map<String, dynamic>? params,
      String? id}) async {
    Response response;
    url = id != null && id.isNotEmpty ? '$url/$id' : url;
    try {
      response = await _dio.get(url,
          queryParameters: {"api_key": ApiParams.apiKey},
          data: params,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }));
    } on DioException catch (exception) {
      return Future.error(exception.toString());
    } catch (exception) {
      return Future.error(exception);
    }
    return response;
  }

  Future post({
    required String url,
    required Map<String, dynamic> params,
  }) async {
    var formData = FormData.fromMap({
      ...params,
    });
    Response response;
    logger.d(params);
    try {
      response = await _dio.post(url,
          data: formData, queryParameters: {}, options: Options(headers: {}));

      // Check if the status code is 400 and show the message from the API
    } on DioException catch (exception) {
      if (exception.response!.statusCode != 200) {
        var errormsg = exception.message ?? "Something Went Wrong!!!";
        Fluttertoast.showToast(msg: errormsg);
        return Future.error(errormsg);
      } else {
        Fluttertoast.showToast(
            msg: exception.message ?? "Something Went Wrong!!!");
        return Future.error(exception.message ?? "Something Went Wrong!!!");
      }
    } catch (exception) {
      Fluttertoast.showToast(msg: exception.toString());
      return Future.error(exception);
    }

    return response;
  }
}
