import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/modules/pokemon_game/presentation/providers/pokemon_game_provider.dart';
import 'package:gemini_app/modules/pokemon_game/presentation/widgets/widgets.dart';

class PokemonGallery extends ConsumerWidget {
  const PokemonGallery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonGame = ref.watch(pokemonListGameProvider);

    return Expanded(
      child: GridView.builder(
        itemCount: pokemonGame.pokemonList.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 0.48, // mas alto que ancho de los hijo
          maxCrossAxisExtent: 200, // anncho maximo de los hijos
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final pokemon = pokemonGame.pokemonList[index];
          return PokemonCard(pokemon: pokemon);
        },
      ),
    );
  }
}

/**
 GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return PokemonCard();
        },
      )
 */
