import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:gemini_app/presentation/providers/users/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:gemini_app/presentation/providers/chat/is_gemini_typing.dart';

part "basic_chat.g.dart";

final uuid = Uuid();

@riverpod
class BasicChat extends _$BasicChat {
  @override
  List<Message> build() {
    return [];
  }

  void addMessage({
    required String text,
    required User user,
    required InMemoryChatController chatController,
  }) {
    // TODO: agregar condicion cuando vengan imagenes
    _addTextMessage(text: text, user: user, chatController: chatController);
  }

  Future<void> _addTextMessage({
    required String text,
    required User user,
    required InMemoryChatController chatController,
  }) async {
    final message = TextMessage(
      id: uuid.v4(),
      authorId: user.id,
      createdAt: DateTime.now().toUtc(),
      text: text,
    );

    state = [message, ...state];
    chatController.insertMessage(message);
    _geminiTextResponse(prompt: text, chatController: chatController);
  }

  Future<void> _geminiTextResponse({
    required String prompt,
    required InMemoryChatController chatController,
  }) async {
    final geminiUser = ref.read(geminiUserProvider);

    await _toggleTyping(chatController);
    await Future.delayed(const Duration(milliseconds: 1000));

    final message = TextMessage(
      id: uuid.v4(),
      authorId: geminiUser.id,
      createdAt: DateTime.now().toUtc(),
      text: 'Hola desde Gemini ✨',
    );

    state = [message, ...state];
    await chatController.insertMessage(message);

    await _toggleTyping(chatController);
  }

  Future<void> _toggleTyping(InMemoryChatController chatController) async {
    final isGeminiTyping = ref.watch(isGeminiTypingProvider.notifier).state;

    if (!isGeminiTyping) {
      await chatController.insertMessage(
        CustomMessage(
          id: 'typing-${uuid.v4()}',
          authorId: ref.watch(geminiUserProvider).id,
          metadata: {'type': 'typing'},
          createdAt: DateTime.now().toUtc(),
        ),
      );
      ref.read(isGeminiTypingProvider.notifier).setIsTyping();
    } else {
      try {
        final typingMessage = chatController.messages.firstWhere(
          (message) => message.metadata?['type'] == 'typing',
        );
        ref.read(isGeminiTypingProvider.notifier).setIsNotTyping();
        await chatController.removeMessage(typingMessage, animated: false);
      } catch (e) {
        ref.read(isGeminiTypingProvider.notifier).setIsNotTyping();
        await _toggleTyping(chatController);
      }
    }
  }
}
