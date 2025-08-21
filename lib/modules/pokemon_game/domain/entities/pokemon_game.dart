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
  List<String> tipes;

  PokemonList({
    required this.name,
    required this.attack,
    required this.pokedexNumber,
    required this.imgageUrl,
    required this.tipes,
  });
}

class PokemonAttack {
  String es;
  String en;

  PokemonAttack({required this.es, required this.en});
}
