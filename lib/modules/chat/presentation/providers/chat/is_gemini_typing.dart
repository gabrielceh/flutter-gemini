import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_gemini_typing.g.dart';

@riverpod
class IsGeminiTyping extends _$IsGeminiTyping {
  // creamos el estado inicial
  @override
  bool build() => false;

  void setIsTyping() {
    state = true;
  }

  void setIsNotTyping() {
    state = false;
  }
}
