import 'package:flutter/material.dart';
import 'package:gemini_app/config/helpers/text_capitalize.dart';
import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';
import 'package:gemini_app/modules/pokemon_game/helpers/pokemon_type_color.dart';
import 'package:gemini_app/modules/pokemon_game/helpers/pokemon_type_image.dart';

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
                  Text(
                    pokemon.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: PokemonTypeColor.getContrastColor(
                        PokemonType.grass,
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Image.network(pokemon.imgageUrl, width: 180, height: 180),

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

                  Column(
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
                        textCapitalize(pokemon.attack.es),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey[900],
                        ),
                      ),
                      Text(
                        textCapitalize(pokemon.attack.en),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey[900],
                        ),
                      ),
                    ],
                  ),
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
        width: 200,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor, // Solo color plano
        ),
      ),
    );
  }
}
