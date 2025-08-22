enum PokemonType {
  bug,
  dark,
  dragon,
  electric,
  fairy,
  fighting,
  fire,
  flying,
  ghost,
  grass,
  ground,
  ice,
  normal,
  poison,
  psychic,
  rock,
  steel,
  water;

  /// Convierte un string a PokemonType (case-insensitive)
  static PokemonType? fromString(String type) {
    final normalizedType = type.toLowerCase().trim();
    for (final pokemonType in PokemonType.values) {
      if (pokemonType.name == normalizedType) {
        return pokemonType;
      }
    }
    return null;
  }

  /// Verifica si un string representa un tipo válido
  static bool isValid(String type) {
    return fromString(type) != null;
  }

  /// Obtiene el nombre capitalizado del tipo
  String get displayName {
    return name[0].toUpperCase() + name.substring(1);
  }
}
