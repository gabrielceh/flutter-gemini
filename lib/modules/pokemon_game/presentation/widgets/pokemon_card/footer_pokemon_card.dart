import 'package:flutter/material.dart';

import 'package:gemini_app/config/helpers/text_capitalize.dart';
import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';

class FooterPokemonCard extends StatelessWidget {
  final PokemonAttack pokemonAttack;

  const FooterPokemonCard({super.key, required this.pokemonAttack});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2.5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ataque efectivo:",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.grey[900],
          ),
        ),
        Text(
          textCapitalize(pokemonAttack.es),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.grey[900],
          ),
        ),
        Text(
          textCapitalize(pokemonAttack.en),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Colors.grey[900],
          ),
        ),
      ],
    );
  }
}
