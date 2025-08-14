import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Gemini ✨')),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.purple,
              child: Icon(Icons.person_outlined),
            ),
            title: Text('Prompt Básico a Gemini'),
            subtitle: Text('Usando un módelo Flash'),
            onTap: () => context.push('/basic-prompt'),
          ),
        ],
      ),
    );
  }
}
