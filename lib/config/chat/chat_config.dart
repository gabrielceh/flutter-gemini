import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatConfig {
  Future<User> Function(String userId) resolveUser;

  ChatConfig({required this.resolveUser});

  Widget chatMessageBuilder(
    BuildContext context,
    Message message,
    int index,
    Animation<double> animation,
    Widget child, {
    bool? isRemoved,
    required bool isSentByMe,
    MessageGroupStatus? groupStatus,
  }) {
    return FutureBuilder<User>(
      future: resolveUser(message.authorId),
      builder: (context, snapshot) {
        final user = snapshot.data;

        return ChatMessage(
          message: message,
          index: index,
          animation: animation,
          isRemoved: isRemoved,
          groupStatus: groupStatus,

          leadingWidget: isSentByMe || user == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: user.imageSource != null
                        ? NetworkImage(user.imageSource!)
                        : null,
                    child: user.imageSource == null
                        ? Text(user.name![0])
                        : null,
                  ),
                ),

          // Nombre del usuario (solo para el primer mensaje del grupo)
          topWidget: Padding(
            padding: EdgeInsets.only(left: 48, bottom: 4),
            child: Text(
              '${user?.name}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          child: child,
        );
      },
    );
  }
}
