import 'package:flutter/material.dart';
import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';
import 'package:gemini_app/modules/pokemon_game/helpers/pokemon_type_color.dart';
import 'package:gemini_app/modules/pokemon_game/helpers/pokemon_type_image.dart';

import 'pokemon_card/footer_pokemon_card.dart';
import 'pokemon_card/header_pokemon_card.dart';

class PokemonCard extends StatelessWidget {
  final PokemonList pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),

        child: Stack(
          children: [
            ...pokemon.types
                .asMap()
                .entries
                .map((entry) {
                  int index = entry.key;
                  PokemonType type = entry.value;
                  return _SimplePokemonBackground(
                    top: index == 1 ? -50 : -60,
                    backgroundColor: PokemonTypeColor.getColor(type),
                  );
                })
                .toList()
                .reversed,

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PokemonCardHeader(
                    pokemonName: pokemon.name,
                    pokedexNumber: pokemon.pokedexNumber,
                    pokemonType: pokemon.types.first,
                  ),

                  Image.network(pokemon.imgageUrl, width: 160, height: 160),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: pokemon.types
                        .map(
                          (type) => Image.asset(
                            PokemonTypeImage.getImage(type),
                            width: 60,
                          ),
                        )
                        .toList(),
                  ),

                  FooterPokemonCard(pokemonAttack: pokemon.attack),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimplePokemonBackground extends StatelessWidget {
  final Color backgroundColor;
  final double top;

  const _SimplePokemonBackground({
    required this.backgroundColor,
    required this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: -20,
      child: Container(
        width: 350,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor, // Solo color plano
        ),
      ),
    );
  }
}
