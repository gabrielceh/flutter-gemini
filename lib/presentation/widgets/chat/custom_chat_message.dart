import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:gemini_app/presentation/widgets/chat/name_message.dart';

class CustomChatMessage extends StatelessWidget {
  final BuildContext context;
  final Message message;
  final int index;
  final Animation<double> animation;
  final bool isSentByMe;
  final Widget child;
  final MessageGroupStatus? groupStatus;
  final bool? isRemoved;
  final bool? isTyping;
  final User? user;

  const CustomChatMessage({
    super.key,
    required this.context,
    required this.message,
    required this.index,
    required this.animation,
    required this.isSentByMe,
    required this.child,
    this.groupStatus,
    this.isRemoved,
    this.isTyping,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ChatMessage(
      message: message,
      index: index,
      animation: animation,
      isRemoved: isRemoved,
      groupStatus: groupStatus,
      // Avatar (solo para otros usuarios, no para ti)
      leadingWidget: isSentByMe || user == null
          ? null
          : message.metadata?['type'] != 'typing'
          ? Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Avatar(userId: user!.id),
            )
          : null,

      // Nombre del usuario (solo para el primer mensaje del grupo)
      topWidget: isSentByMe || user == null
          ? null
          : message.metadata?['type'] != 'typing'
          ? NameMessage(user: user!)
          : null,

      child: (message.metadata?['type'] == 'typing' && isTyping == true)
          ? Row(spacing: 10, children: [IsTypingIndicator()])
          : child,
    );
  }
}
