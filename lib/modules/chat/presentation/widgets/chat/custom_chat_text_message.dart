import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';

import 'name_message.dart';

class CustomChatTextMessage extends StatelessWidget {
  final BuildContext context;
  final TextMessage message;
  final int index;
  final bool isSentByMe;
  final MessageGroupStatus? groupStatus;
  final User? user;
  final bool? isTyping;

  const CustomChatTextMessage({
    super.key,
    required this.context,
    required this.message,
    required this.index,
    required this.isSentByMe,
    this.user,
    this.groupStatus,
    this.isTyping,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadiusMe = BorderRadius.only(
      bottomLeft: Radius.circular(12),
      topLeft: Radius.circular(12),
      bottomRight: Radius.circular(12),
    );
    final borderRadiusNotMe = BorderRadius.only(
      bottomRight: Radius.circular(12),
      bottomLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    );

    return FlyerChatTextMessage(
      message: message,
      index: index,
      showTime: false,
      showStatus: false,
      padding: isSentByMe || user == null
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
          : EdgeInsets.zero,
      topWidget: isSentByMe || user == null ? null : NameMessage(user: user!),
      sentBackgroundColor: Colors.purple[900],
      receivedBackgroundColor: Colors.purple[500],
      borderRadius: isSentByMe ? borderRadiusMe : borderRadiusNotMe,
    );
  }
}
