import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gemini_app/config/constants/enviroment.dart';
import 'package:image_picker/image_picker.dart';

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

  // // async* es una funcion generadora para regresar un streanm¿¿m
  // Stream<String> getResponseStream(String prompt, {List<XFile> files=const[]}) async* {
  //   try {
  //     final body = jsonEncode({'prompt': prompt});
  //     final response = await _dio.post(
  //       '/basic-prompt-stream',
  //       data: body,
  //       options: Options(
  //         responseType:
  //             ResponseType.stream, // indicamos que la respuestas será un stream
  //       ),
  //     );
  //     final stream = response.data.stream as Stream<List<int>>;
  //     String buffer = '';
  //     await for (final chunk in stream) {
  //       final chunkStream = utf8.decode(chunk, allowMalformed: true);
  //       buffer += chunkStream;
  //       // print(buffer);
  //       yield buffer; // vamos regresando el buffer cada vez que haya un nuevo chunk
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     throw Exception("Can't get Gemini✨ response");
  //   }
  // }

  // async* es una funcion generadora para regresar un streanm¿¿m
  Stream<String> getResponseStream(
    String prompt, {
    List<XFile> files = const [],
  }) async* {
    try {
      // ! Multipart
      final formData = FormData(); // creamos el formData
      formData.fields.add(
        MapEntry('prompt', prompt),
      ); // añadimos el campo prompt (necesario segun la API)

      if (files.isNotEmpty) {
        for (final file in files) {
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(file.path, filename: file.name),
            ),
          );
        }
      }

      // final body = jsonEncode({'prompt': prompt});
      final response = await _dio.post(
        '/basic-prompt-stream',
        data: formData,
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

  Stream<String> getChatStream(
    String prompt,
    String chatId, {
    List<XFile> files = const [],
  }) async* {
    try {
      // ! Multipart
      final formData = FormData(); // creamos el formData
      formData.fields.add(MapEntry('prompt', prompt));
      formData.fields.add(MapEntry('chatId', chatId));

      if (files.isNotEmpty) {
        for (final file in files) {
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(file.path, filename: file.name),
            ),
          );
        }
      }

      // final body = jsonEncode({'prompt': prompt});
      final response = await _dio.post(
        '/chat-stream',
        data: formData,
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
