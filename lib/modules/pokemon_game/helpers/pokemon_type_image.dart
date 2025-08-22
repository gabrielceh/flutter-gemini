import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';

class PokemonTypeImage {
  // Constructor privado para prevenir instanciación
  PokemonTypeImage._();

  /// Mapa inmutable de rutas de imágenes por tipo de Pokémon
  static const Map<PokemonType, String> _imagePaths = {
    PokemonType.bug: "assets/images/pokemon_types/bicho.png",
    PokemonType.dark: "assets/images/pokemon_types/siniestro.png",
    PokemonType.dragon: "assets/images/pokemon_types/dragon.png",
    PokemonType.electric: "assets/images/pokemon_types/electrico.png",
    PokemonType.fairy: "assets/images/pokemon_types/hada.png",
    PokemonType.fighting: "assets/images/pokemon_types/lucha.png",
    PokemonType.fire: "assets/images/pokemon_types/fuego.png",
    PokemonType.flying: "assets/images/pokemon_types/volador.png",
    PokemonType.ghost: "assets/images/pokemon_types/fantasma.png",
    PokemonType.grass: "assets/images/pokemon_types/planta.png",
    PokemonType.ground: "assets/images/pokemon_types/tierra.png",
    PokemonType.ice: "assets/images/pokemon_types/hielo.png",
    PokemonType.normal: "assets/images/pokemon_types/normal.png",
    PokemonType.poison: "assets/images/pokemon_types/veneno.png",
    PokemonType.psychic: "assets/images/pokemon_types/psiquico.png",
    PokemonType.rock: "assets/images/pokemon_types/roca.png",
    PokemonType.steel: "assets/images/pokemon_types/acero.png",
    PokemonType.water: "assets/images/pokemon_types/agua.png",
  };

  /// Ruta base para las imágenes de tipos
  static const String _basePath = "assets/images/pokemon_types/";

  /// Imagen por defecto cuando no se encuentra el tipo
  static const String _defaultImage = "${_basePath}normal.png";

  /// Obtiene la ruta de imagen para un tipo de Pokémon usando enum
  static String getImage(PokemonType type) {
    return _imagePaths[type] ?? _defaultImage;
  }

  /// Obtiene la ruta de imagen para un tipo de Pokémon usando string
  /// Soporta tanto mayúsculas como minúsculas
  static String getImageFromString(String type) {
    final pokemonType = PokemonType.fromString(type);
    return pokemonType != null ? getImage(pokemonType) : _defaultImage;
  }

  /// Obtiene todas las rutas de imágenes disponibles
  static List<String> get allImagePaths => _imagePaths.values.toList();

  /// Obtiene un mapa de tipo → ruta de imagen
  static Map<PokemonType, String> get typeImageMap =>
      Map.unmodifiable(_imagePaths);

  /// Verifica si existe una imagen para el tipo dado
  static bool hasImage(PokemonType type) {
    return _imagePaths.containsKey(type);
  }

  /// Verifica si existe una imagen para el tipo dado (string)
  static bool hasImageForString(String type) {
    final pokemonType = PokemonType.fromString(type);
    return pokemonType != null && hasImage(pokemonType);
  }

  /// Obtiene el nombre del archivo de imagen (sin la ruta)
  static String getImageFileName(PokemonType type) {
    final imagePath = getImage(type);
    return imagePath.split('/').last;
  }

  /// Obtiene la ruta de imagen con un sufijo personalizado (ej: para iconos pequeños)
  static String getImageWithSuffix(PokemonType type, String suffix) {
    final baseName = getImageFileName(type).split('.').first;
    final extension = getImageFileName(type).split('.').last;
    return "$_basePath$baseName$suffix.$extension";
  }
}
