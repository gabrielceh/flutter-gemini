import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/config/theme/app_theme.dart';
import 'package:gemini_app/modules/chat/presentation/providers/chat/chat_with_context.dart';
import 'package:gemini_app/modules/chat/presentation/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

import 'package:gemini_app/modules/chat/presentation/providers/providers.dart';

class ChatContextScreen extends ConsumerStatefulWidget {
  const ChatContextScreen({super.key});

  @override
  ChatContextScreenState createState() => ChatContextScreenState();
}

class ChatContextScreenState extends ConsumerState<ChatContextScreen> {
  final uuid = Uuid();
  final _chatController = InMemoryChatController();
  bool _isFirstRender = true;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listenManual(chatWithContextProvider, (previous, next) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linearToEaseOut,
        );
        if (next.isEmpty && (previous != null && previous.isNotEmpty)) {
          // limpiamos los mensajes
          _chatController.setMessages(next);
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isFirstRender) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeChat();
      });
      _isFirstRender = false;
    }
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeChat() {
    final messages = ref.read(chatWithContextProvider);
    _chatController.insertAllMessages(messages.reversed.toList());
  }

  Future<User> _resolveUser(String userId) async {
    final user = ref.read(userProvider);
    final geminiUser = ref.read(geminiUserProvider);

    if (userId == user.id) {
      return user;
    } else if (userId == geminiUser.id) {
      return geminiUser;
    } else {
      return User(id: uuid.v4(), name: 'Usuario');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat con Gemini'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(chatWithContextProvider.notifier).newChat();
            },
            icon: const Icon(Icons.cleaning_services_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Chat(
          chatController: _chatController,
          currentUserId: user.id,
          resolveUser: _resolveUser,
          theme: ChatTheme.dark(),
          backgroundColor: seedColor,
          builders: Builders(
            chatAnimatedListBuilder: (context, itemBuilder) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: ChatAnimatedList(
                  scrollController: _scrollController,
                  itemBuilder: itemBuilder,
                  // shouldScrollToEndWhenAtBottom: false,
                ),
              );
            },

            emptyChatListBuilder: (context) {
              return Center(child: Text('No hay mensajes'));
            },

            chatMessageBuilder:
                (
                  context,
                  message,
                  index,
                  animation,
                  child, {
                  bool? isRemoved,
                  required bool isSentByMe,
                  MessageGroupStatus? groupStatus,
                }) {
                  return FutureBuilder<User>(
                    future: _resolveUser(message.authorId),
                    builder: (context, snapshot) {
                      // obetenemos el usuario del mensaje
                      final user = snapshot.data;

                      return CustomChatMessage(
                        context: context,
                        message: message,
                        index: index,
                        animation: animation,
                        isSentByMe: isSentByMe,
                        groupStatus: groupStatus,
                        isRemoved: isRemoved,
                        isTyping: ref.watch(isGeminiTypingProvider),
                        user: user,
                        child: child,
                      );
                    },
                  );
                },

            textMessageBuilder:
                (
                  context,
                  message,
                  index, {
                  required bool isSentByMe,
                  MessageGroupStatus? groupStatus,
                }) => CustomChatTextMessage(
                  context: context,
                  message: message,
                  index: index,
                  isSentByMe: isSentByMe,
                ),

            imageMessageBuilder:
                (
                  context,
                  message,
                  index, {
                  required bool isSentByMe,
                  MessageGroupStatus? groupStatus,
                }) => CustomChatImageMedia(
                  context: context,
                  message: message,
                  index: index,
                  isSentByMe: isSentByMe,
                  groupStatus: groupStatus,
                ),

            composerBuilder: (context) {
              return CustomBottomInput(
                onSend: (text, {images = const []}) {
                  final basicChatNotifier = ref.read(
                    chatWithContextProvider.notifier,
                  );
                  basicChatNotifier.addMessage(
                    text: text,
                    user: ref.watch(userProvider),
                    chatController: _chatController,
                    images: images,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
