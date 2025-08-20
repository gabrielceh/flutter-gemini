import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:gemini_app/config/gemini/gemini_impl.dart';
import 'package:gemini_app/presentation/providers/users/user_provider.dart';

part "chat_with_context.g.dart";

final uuid = Uuid();

// Mantener el provider activo para que pueda ser usado en diferentes partes del app
@Riverpod(keepAlive: true)
class ChatWithContext extends _$ChatWithContext {
  final _gemini = GeminiImpl();
  late User geminiUser;
  late String chatId;

  @override
  List<Message> build() {
    geminiUser = ref.read(geminiUserProvider);
    // aqui podriamos obtener el chatId del backend
    chatId = uuid.v4();
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
    _gemini.getChatStream(prompt, chatId, files: images).listen((chunk) {
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

  void newChat() {
    // creamos un nuevo chat
    chatId = uuid.v4();
    state = [];
  }

  void loadPreviousChat() {
    // TODO: hacer la peticion al backend para leer un chat segun el id
  }

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
