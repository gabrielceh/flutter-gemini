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

          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
              child: Icon(Icons.person_outlined),
            ),
            title: Text('Chat'),
            subtitle: Text('Usando un módelo Flash'),
            onTap: () => context.push('/chat-stream'),
          ),

          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.person_outlined),
            ),
            title: Text('Imagenes'),
            subtitle: Text('Generación de imágenes con gemini'),
            onTap: () => context.push('/image-generation'),
          ),

          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red[600],
              child: Icon(Icons.catching_pokemon_outlined),
            ),
            title: Text('Pokemon'),
            subtitle: Text('Pokemon super efectivos'),
            onTap: () => context.push('/pokemon'),
          ),
        ],
      ),
    );
  }
}
