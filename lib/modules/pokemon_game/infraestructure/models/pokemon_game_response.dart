class PokemonGameResponse {
  final String pokemonSelected;
  final int pokedexNumber;
  final List<PokemonListResponse> pokemonList;

  PokemonGameResponse({
    required this.pokemonSelected,
    required this.pokedexNumber,
    required this.pokemonList,
  });

  factory PokemonGameResponse.fromJson(Map<String, dynamic> json) =>
      PokemonGameResponse(
        pokemonSelected: json["pokemonSelected"],
        pokedexNumber: json["pokedexNumber"],
        pokemonList: List<PokemonListResponse>.from(
          json["pokemonList"].map((x) => PokemonListResponse.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "pokemonSelected": pokemonSelected,
    "pokedexNumber": pokedexNumber,
    "pokemonList": List<dynamic>.from(pokemonList.map((x) => x.toJson())),
  };
}

class PokemonListResponse {
  final String name;
  final PokemonAttackResponse attack;
  final int pokedexNumber;
  final List<String> tipes;

  PokemonListResponse({
    required this.name,
    required this.attack,
    required this.pokedexNumber,
    required this.tipes,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) =>
      PokemonListResponse(
        name: json["name"],
        attack: PokemonAttackResponse.fromJson(json["attack"]),
        pokedexNumber: json["pokedexNumber"],
        tipes: List<String>.from(json["tipes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "attack": attack.toJson(),
    "pokedexNumber": pokedexNumber,
    "tipes": List<dynamic>.from(tipes.map((x) => x)),
  };
}

class PokemonAttackResponse {
  final String es;
  final String en;

  PokemonAttackResponse({required this.es, required this.en});

  factory PokemonAttackResponse.fromJson(Map<String, dynamic> json) =>
      PokemonAttackResponse(es: json["es"], en: json["en"]);

  Map<String, dynamic> toJson() => {"es": es, "en": en};
}
