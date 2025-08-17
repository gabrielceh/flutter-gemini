import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';

import 'name_message.dart';

class CustomChatImageMedia extends StatelessWidget {
  final User? user;
  final BuildContext context;
  final ImageMessage message;
  final int index;
  final Animation<double> animation;
  final bool isSentByMe;
  final MessageGroupStatus? groupStatus;

  const CustomChatImageMedia({
    super.key,
    required this.context,
    required this.message,
    required this.index,
    required this.animation,
    required this.isSentByMe,
    this.user,
    this.groupStatus,
  });

  @override
  Widget build(BuildContext context) {
    return FlyerChatImageMessage(
      message: message,
      index: index,
      showTime: false,
      showStatus: false,
      topWidget: isSentByMe || user == null ? null : NameMessage(user: user!),
    );
  }
}
