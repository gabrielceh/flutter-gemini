import 'package:flutter/material.dart';
import 'package:gemini_app/modules/pokemon_game/presentation/widgets/pokemon_gallery.dart';
import 'package:gemini_app/modules/pokemon_game/presentation/widgets/widgets.dart';

class PokemonGameScreen extends StatelessWidget {
  const PokemonGameScreen({super.key});

  onSend(String message) {
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokemon')),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            CustomTextField(onSend: onSend),

            PokemonGallery(),
          ],
        ),
      ),
    );
  }
}
