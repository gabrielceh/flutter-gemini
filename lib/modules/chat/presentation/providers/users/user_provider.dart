import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
User geminiUser(Ref ref) {
  final geminiUser = User(
    id: 'gemini-id',
    name: 'Gemini',
    imageSource:
        'https://play-lh.googleusercontent.com/bTpNtZ6rYYX2SeI-wC4cnr7MJnOh2hjtgYu3UIrSxE09lM3GPl_Uhf9_Ih2Smje2bc0V',
  );

  return geminiUser;
}

@riverpod
User user(Ref ref) {
  final user = User(
    id: 'user-id',
    name: 'Yo',
    imageSource:
        'https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png',
  );

  return user;
}
