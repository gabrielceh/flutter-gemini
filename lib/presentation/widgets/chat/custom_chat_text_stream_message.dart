import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flyer_chat_text_stream_message/flyer_chat_text_stream_message.dart';

class CustomChatTextStreamMessage<T> extends StatelessWidget {
  final User? user;
  final TextStreamMessage message;
  final int index;
  final bool isSentByMe;
  final MessageGroupStatus? groupStatus;
  final Function(String messageId) getState;

  CustomChatTextStreamMessage({
    super.key,
    required this.message,
    required this.index,
    required this.isSentByMe,
    required this.getState,
    this.user,
    this.groupStatus,
  });

  final Duration _kChunkAnimationDuration = Duration(milliseconds: 350);

  @override
  Widget build(BuildContext context) {
    final streamState = getState(message.streamId);

    return FlyerChatTextStreamMessage(
      message: message,
      index: index,
      streamState: streamState,
      chunkAnimationDuration: _kChunkAnimationDuration,
      showTime: false,
      showStatus: false,
      receivedBackgroundColor: Colors.transparent,
      loadingText: 'Pensando...',

      padding: isSentByMe || user == null
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
          : EdgeInsets.zero,
    );
  }
}
