import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gemini_app/config/constants/enviroment.dart';

class GeminiImpl {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Environment.endpointApi,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<String> getResponse(String prompt) async {
    final body = ({'prompt': prompt});

    final response = await dio.post('/basic-prompt', data: body);

    print(response.data);

    return 'Hola mundo desde gemini';
  }
}
