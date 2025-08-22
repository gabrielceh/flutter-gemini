import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemini_app/modules/pokemon_game/presentation/providers/is_generating_pokemon_game.dart';
import 'package:gemini_app/modules/pokemon_game/presentation/providers/pokemon_game_provider.dart';
import 'package:gemini_app/modules/pokemon_game/presentation/widgets/widgets.dart';

class PokemonGameScreen extends ConsumerWidget {
  const PokemonGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonList = ref.watch(pokemonListGameProvider);
    final isGenerating = ref.watch(isGeneratingPokemonGameProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Pokemon')),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          spacing: 20,
          children: [
            CustomTextField(
              onSend: (pokemonName) async {
                ref
                    .read(pokemonListGameProvider.notifier)
                    .getPokemon(pokemonName);
              },
            ),
            if (isGenerating) const CircularProgressIndicator(),

            if (!isGenerating && pokemonList.pokemonList.isNotEmpty)
              PokemonGallery(),

            if (!isGenerating && pokemonList.pokemonList.isEmpty)
              Text("No hay Pokémon"),
          ],
        ),
      ),
    );
  }
}
