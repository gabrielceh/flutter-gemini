import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flyer_chat_text_stream_message/flyer_chat_text_stream_message.dart';
import 'package:gemini_app/presentation/providers/chat/basic_chat.dart';
import 'package:gemini_app/presentation/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

import 'package:gemini_app/presentation/providers/providers.dart';

final uuid = Uuid();

class BasicPromptScreen extends ConsumerStatefulWidget {
  const BasicPromptScreen({super.key});

  @override
  BasicPromptScreenState createState() => BasicPromptScreenState();
}

class BasicPromptScreenState extends ConsumerState<BasicPromptScreen> {
  final _chatController = InMemoryChatController();
  bool _isFirstRender = true;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // vigilamos los cambios del estado para poder actualizar el scroll
    ref.listenManual(basicChatProvider, (previous, next) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linearToEaseOut,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ahora sí es seguro leer el provider
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
    final messages = ref.read(basicChatProvider);
    _chatController.insertAllMessages(messages);
  }

  // Función para resolver información del usuario
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

  // Maneja el envío de mensajes del usuario
  void _handleMessageSent(String message) async {
    final basicChatNotifier = ref.read(basicChatProvider.notifier);
    basicChatNotifier.addMessage(
      text: message,
      user: ref.watch(userProvider),
      chatController: _chatController,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Consulta básica')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Chat(
          chatController: _chatController,
          currentUserId: user.id,
          resolveUser: _resolveUser,
          onMessageSend: _handleMessageSent,
          theme: ChatTheme.dark(),
          builders: Builders(
            chatAnimatedListBuilder: (context, itemBuilder) {
              return ChatAnimatedList(
                scrollController: _scrollController,
                itemBuilder: itemBuilder,
                // shouldScrollToEndWhenAtBottom: false,
              );
            },
            // mensahe cuando no hay mensajes
            emptyChatListBuilder: (context) {
              return Center(child: Text('No hay mensajes'));
            },
            // mensahe default
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

            // mensajes de texto personalizados
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

            // textStreamMessageBuilder:
            //     (
            //       context,
            //       message,
            //       index, {
            //       required bool isSentByMe,
            //       MessageGroupStatus? groupStatus,
            //     }) {
            //       // Watch the manager for state updates
            //       final streamState = context.watch<BasicPromptScreenState>().getState(message.streamId);
            //       // Return the stream message widget, passing the state
            //       return FlyerChatTextStreamMessage(
            //         message: message,
            //         index: index,
            //         streamState: streamState,
            //         chunkAnimationDuration: _kChunkAnimationDuration,
            //         showTime: false,
            //         showStatus: false,
            //         receivedBackgroundColor: Colors.transparent,
            //         padding: message.authorId == _agent.id
            //             ? EdgeInsets.zero
            //             : const EdgeInsets.symmetric(
            //                 horizontal: 16,
            //                 vertical: 10,
            //               ),
            //       );
            //     },
          ),
        ),
      ),
    );
  }
}
