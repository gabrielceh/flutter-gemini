import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

class AvatarMessage extends StatelessWidget {
  final User user;

  const AvatarMessage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: user.imageSource != null
            ? NetworkImage(user.imageSource!)
            : null,
        child: user.imageSource == null ? Text(user.name![0]) : null,
      ),
    );
  }
}
