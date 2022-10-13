import 'package:dio/dio.dart';
import 'dio.dart';


Future<Map<String, dynamic>> getWeatherInfo(var location) async {

  try {
    var response = await dio.get('data/2.5/weather?q=$location&appid=901a28533b4879dfbcfe1523f7eaebd2',);
      return {'status': 'success', 'data': response.data};
  } on DioError catch (e) {
    return getErrorResponse(e);
  }
}