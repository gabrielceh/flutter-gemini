import 'package:flutter/material.dart';
import 'package:gemini_app/modules/pokemon_game/presentation/widgets/widgets.dart';

class PokemonGallery extends StatelessWidget {
  const PokemonGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
    );
  }
}
