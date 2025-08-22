import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:gemini_app/config/gemini/gemini_impl.dart';
import 'package:gemini_app/modules/chat/presentation/providers/users/user_provider.dart';

part "basic_chat.g.dart";

final uuid = Uuid();

@riverpod
class BasicChat extends _$BasicChat {
  final _gemini = GeminiImpl();
  late User geminiUser;

  @override
  List<Message> build() {
    geminiUser = ref.read(geminiUserProvider);
    return [];
  }

  void addMessage({
    required String text,
    required User user,
    List<XFile> images = const [],
    required InMemoryChatController chatController,
  }) {
    if (images.isNotEmpty) {
      _addTextMessageWithImages(
        text: text,
        user: user,
        chatController: chatController,
        images: images,
      );
      return;
    }

    _addTextMessage(text: text, user: user, chatController: chatController);
  }

  Future<void> _addTextMessage({
    required String text,
    required User user,
    required InMemoryChatController chatController,
  }) async {
    await _createTextMessage(
      text: text,
      author: user,
      chatController: chatController,
    );

    // _geminiTextResponse(prompt: text, chatController: chatController);
    _geminiTextResponseStream(prompt: text, chatController: chatController);
  }

  Future<void> _addTextMessageWithImages({
    required String text,
    required User user,
    required InMemoryChatController chatController,
    required List<XFile> images,
  }) async {
    for (XFile image in images) {
      await _createImageMessage(
        image: image,
        author: user,
        chatController: chatController,
      );
    }

    await _createTextMessage(
      text: text,
      author: user,
      chatController: chatController,
    );

    await _geminiTextResponseStream(
      prompt: text,
      chatController: chatController,
      images: images,
    );
  }

  // Future<void> _geminiTextResponse({
  //   required String prompt,
  //   required InMemoryChatController chatController,
  // }) async {
  //   await _toggleTyping(chatController);
  //   // await Future.delayed(const Duration(seconds: 1));
  //   final response = await _gemini.getResponse(prompt);
  //   await _createTextMessage(
  //     text: response,
  //     author: geminiUser,
  //     chatController: chatController,
  //   );
  //   await _toggleTyping(chatController);
  // }

  Future<void> _geminiTextResponseStream({
    required String prompt,
    required InMemoryChatController chatController,
    List<XFile> images = const [],
  }) async {
    await _createTextMessage(
      text: "Gemini esta pensando...",
      author: geminiUser,
      chatController: chatController,
    );
    _gemini.getResponseStream(prompt, files: images).listen((chunk) {
      if (chunk.isEmpty) return;

      final updatedMessages = [...state];
      final oldMessage = (updatedMessages.first as TextMessage);
      final updatedMessage = (updatedMessages.first as TextMessage).copyWith(
        text: chunk,
      );

      updatedMessages[0] = updatedMessage;
      chatController.updateMessage(oldMessage, updatedMessage);
      state = updatedMessages;
    });
  }

  // HELPER METHODS

  // Future<void> _toggleTyping(InMemoryChatController chatController) async {
  //   final isGeminiTyping = ref.watch(isGeminiTypingProvider.notifier).state;

  //   if (!isGeminiTyping) {
  //     // añadimos un mensaje custom que sera el "typing"
  //     await chatController.insertMessage(
  //       CustomMessage(
  //         id: 'typing-${uuid.v4()}',
  //         authorId: ref.watch(geminiUserProvider).id,
  //         metadata: {'type': 'typing'},
  //         createdAt: DateTime.now().toUtc(),
  //       ),
  //     );
  //     ref.read(isGeminiTypingProvider.notifier).setIsTyping();
  //   } else {
  //     try {
  //       final typingMessage = chatController.messages.firstWhere(
  //         (message) => message.metadata?['type'] == 'typing',
  //       );
  //       ref.read(isGeminiTypingProvider.notifier).setIsNotTyping();
  //       await chatController.removeMessage(typingMessage, animated: false);
  //     } catch (e) {
  //       ref.read(isGeminiTypingProvider.notifier).setIsNotTyping();
  //       await _toggleTyping(chatController);
  //     }
  //   }
  // }

  Future<void> _createTextMessage({
    required String text,
    required User author,
    required InMemoryChatController chatController,
  }) async {
    final message = TextMessage(
      id: uuid.v4(),
      authorId: author.id,
      createdAt: DateTime.now().toUtc(),
      text: text,
    );

    await chatController.insertMessage(message);
    state = [message, ...state];
  }

  Future<void> _createImageMessage({
    required XFile image,
    required User author,
    required InMemoryChatController chatController,
  }) async {
    final message = ImageMessage(
      id: uuid.v4(),
      authorId: author.id,
      createdAt: DateTime.now().toUtc(),
      source: image.path,
      size: await image.length(),
    );

    await chatController.insertMessage(message);
    state = [message, ...state];
  }
}
