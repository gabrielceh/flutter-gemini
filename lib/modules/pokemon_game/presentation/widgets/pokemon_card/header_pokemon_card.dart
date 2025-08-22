import 'package:flutter/material.dart';
import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';
import 'package:gemini_app/modules/pokemon_game/helpers/pokemon_type_color.dart';

class PokemonCardHeader extends StatelessWidget {
  final String pokemonName;
  final int pokedexNumber;
  final PokemonType pokemonType;

  const PokemonCardHeader({
    super.key,
    required this.pokemonName,
    required this.pokedexNumber,
    required this.pokemonType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pokemonName.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: PokemonTypeColor.getContrastColor(pokemonType),
          ),
          textAlign: TextAlign.left,
        ),
        Text('# $pokedexNumber'),
      ],
    );
  }
}
