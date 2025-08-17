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

  // async* es una funcion generadora para regresar un streanm¿¿m
  Stream<String> getResponseStream(String prompt) async* {
    try {
      // TODO: tener presente que enviaremos imagenes
      final body = jsonEncode({'prompt': prompt});
      final response = await _dio.post(
        '/basic-prompt-stream',
        data: body,
        options: Options(
          responseType:
              ResponseType.stream, // indicamos que la respuestas será un stream
        ),
      );
      final stream = response.data.stream as Stream<List<int>>;
      String buffer = '';
      await for (final chunk in stream) {
        final chunkStream = utf8.decode(chunk, allowMalformed: true);
        buffer += chunkStream;
        // print(buffer);
        yield buffer; // vamos regresando el buffer cada vez que haya un nuevo chunk
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Can't get Gemini✨ response");
    }
  }
}
