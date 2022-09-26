import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  static Future<Response> getDate ({

    required String url,
    required Map<String, dynamic> query,

    }) async {

    return await dio.get(url, queryParameters: query,);
  }

  static Future<Response> postDate({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async{
    return await dio.post(url,queryParameters: query ,data: data);
  }

}