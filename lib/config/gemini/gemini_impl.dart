import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gemini_app/config/constants/enviroment.dart';

class GeminiImpl {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Environment.endpointApi,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<String> getResponse(String prompt) async {
    try {
      final body = jsonEncode({'prompt': prompt});
      final response = await _dio.post('/basic-prompt', data: body);
      return response.data;
    } catch (e) {
      print('Error: $e');
      throw Exception("Can't get Gemini✨ response");
    }
  }
}
