import 'package:gemini_app/modules/pokemon_game/domain/entities/pokemon_type_enum.dart';

class PokemonGame {
  String pokemonSelected;
  int pokedexNumber;
  String imgageUrl;
  List<PokemonList> pokemonList;

  PokemonGame({
    required this.pokemonSelected,
    required this.pokemonList,
    required this.pokedexNumber,
    required this.imgageUrl,
  });
}

class PokemonList {
  String name;
  PokemonAttack attack;
  int pokedexNumber;
  String imgageUrl;
  List<PokemonType> types;

  PokemonList({
    required this.name,
    required this.attack,
    required this.pokedexNumber,
    required this.imgageUrl,
    required this.types,
  });
}

class PokemonAttack {
  String es;
  String en;

  PokemonAttack({required this.es, required this.en});
}
