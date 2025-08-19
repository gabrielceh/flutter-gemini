import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';

import 'name_message.dart';

class CustomChatImageMedia extends StatelessWidget {
  final User? user;
  final BuildContext context;
  final ImageMessage message;
  final int index;
  final bool isSentByMe;
  final MessageGroupStatus? groupStatus;

  const CustomChatImageMedia({
    super.key,
    required this.context,
    required this.message,
    required this.index,
    required this.isSentByMe,
    this.user,
    this.groupStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSentByMe ? Colors.purple[900] : Colors.purple[500],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlyerChatImageMessage(
            message: message,
            index: index,
            showTime: false,
            showStatus: false,
            topWidget: isSentByMe || user == null
                ? null
                : NameMessage(user: user!),
          ),
        ),
      ),
    );
  }
}
