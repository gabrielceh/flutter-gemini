import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

class NameMessage extends StatelessWidget {
  final User user;

  const NameMessage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 48, bottom: 4),
      child: Text(
        '${user.name}',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
