import 'dart:convert';
import 'package:dio/dio.dart';

BaseOptions options = BaseOptions(
    baseUrl: 'https://api.openweathermap.org/'

);

var dio = Dio(options);

Map<String, dynamic> getServerFailureResponse() {
  return {
    'status': 'fail',
    'data': {
      'non_field_errors': ['Something went wrong']
    }
  };
}

Map<String, dynamic> getTimeoutResponse() {
  return {
    'status': 'fail',
    'data': {
      'non_field_errors': ['Unable to connect to the server']
    }
  };
}

Map<String, dynamic> getConnectionErrorResponse() {
  return {
    'status': 'fail',
    'data': {
      'non_field_errors': ['Check your connection']
    }
  };
}

Map<String, dynamic> getServerErrorResponse(e) {
  return {
    'status': 'fail',
    'data': jsonDecode(e.response.toString())
  };
}

Map<String, dynamic> getErrorResponse(e) {
  if (e.type == DioErrorType.badResponse) {
    return getServerErrorResponse(e);
  }

  if (e.type == DioErrorType.connectionTimeout) {
    return getConnectionErrorResponse();
  }

  if (e.type == DioErrorType.receiveTimeout) {
    return getTimeoutResponse();
  }

  return getServerFailureResponse();
}