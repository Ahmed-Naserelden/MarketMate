import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> getDate ({
    required String url,
    String lang = 'ar',
    String? authorization,
    required Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': authorization,
    };
    return await dio.get(url, queryParameters: query,);
  }


  static Future<Response> postDate({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? authorization,
  }) async{

    dio.options.headers = {
      'lang': lang,
      'Authorization': authorization,
    };


    return await dio.post(
        url,
        data: data,
        queryParameters: query,
    );
  }

}