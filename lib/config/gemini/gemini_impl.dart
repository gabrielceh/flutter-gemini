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
      yield* _getStreamResponse(
        endpoint: '/basic-prompt-stream',
        prompt: prompt,
        files: files,
      );
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
      yield* _getStreamResponse(
        endpoint: '/chat-stream',
        prompt: prompt,
        formFields: {'chatId': chatId},
        files: files,
      );
    } catch (e) {
      print('Error: $e');
      throw Exception("Can't get Gemini✨ response");
    }
  }

  // Emitir el stream de información
  Stream<String> _getStreamResponse({
    required String endpoint,
    required String prompt,
    List<XFile> files = const [],
    Map<String, dynamic> formFields = const {},
  }) async* {
    //! Multipart
    final formData = FormData();
    formData.fields.add(MapEntry('prompt', prompt));
    for (final entry in formFields.entries) {
      formData.fields.add(MapEntry(entry.key, entry.value));
    }

    //! Archivos a subir
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

    final response = await _dio.post(
      endpoint,
      data: formData,
      options: Options(responseType: ResponseType.stream),
    );

    final stream = response.data.stream as Stream<List<int>>;
    String buffer = '';

    await for (final chunk in stream) {
      final chunkString = utf8.decode(chunk, allowMalformed: true);
      buffer += chunkString;
      yield buffer;
    }
  }
}
