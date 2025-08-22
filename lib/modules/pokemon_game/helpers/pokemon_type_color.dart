import 'package:flutter/material.dart';
import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';

class PokemonTypeColor {
  // Constructor privado para prevenir instanciación
  PokemonTypeColor._();

  /// Mapa inmutable de colores por tipo de Pokémon
  static const Map<PokemonType, Color> _colors = {
    PokemonType.bug: Color(0xFF91A118),
    PokemonType.dark: Color(0xFF50413F),
    PokemonType.dragon: Color(0xFF5161E0),
    PokemonType.electric: Color(0xFFFAC000),
    PokemonType.fairy: Color(0xFFEE71EF),
    PokemonType.fighting: Color(0xFFFF8000),
    PokemonType.fire: Color(0xFFE62324),
    PokemonType.flying: Color(0xFF81B9EE),
    PokemonType.ghost: Color(0xFF714170),
    PokemonType.grass: Color(0xFF3CA324),
    PokemonType.ground: Color(0xFF905021),
    PokemonType.ice: Color(0xFF3CD8FE),
    PokemonType.normal: Color(0xFFA0A3A0),
    PokemonType.poison: Color(0xFF8E40CA),
    PokemonType.psychic: Color(0xFFEF4178),
    PokemonType.rock: Color(0xFFAFA980),
    PokemonType.steel: Color(0xFF60A2B9),
    PokemonType.water: Color(0xFF2581F1),
  };

  /// Obtiene el color asociado a un tipo de Pokémon usando enum
  static Color getColor(PokemonType type) {
    return _colors[type] ?? _colors[PokemonType.normal]!;
  }

  /// Obtiene el color asociado a un tipo de Pokémon usando string
  /// Soporta tanto mayúsculas como minúsculas
  static Color getColorFromString(String type) {
    final pokemonType = PokemonType.fromString(type);
    return pokemonType != null
        ? getColor(pokemonType)
        : _colors[PokemonType.normal]!;
  }

  /// Obtiene todos los tipos disponibles
  static List<PokemonType> get allTypes => PokemonType.values;

  /// Obtiene todos los colores disponibles
  static List<Color> get allColors => _colors.values.toList();

  /// Verifica si un string representa un tipo válido
  static bool isValidType(String type) {
    return PokemonType.isValid(type);
  }

  /// Obtiene un color más claro del tipo (útil para fondos)
  static Color getLightColor(PokemonType type, {double opacity = 0.2}) {
    return getColor(type).withValues(alpha: opacity);
  }

  /// Obtiene un color más oscuro del tipo (útil para bordes o texto)
  static Color getDarkColor(PokemonType type, {double factor = 0.7}) {
    final color = getColor(type);
    return Color.fromARGB(
      (color.a * 255.0).round() & 0xff,
      ((color.r * 255.0) * factor).round() & 0xff,
      ((color.g * 255.0) * factor).round() & 0xff,
      ((color.b * 255.0) * factor).round() & 0xff,
    );
  }

  /// Obtiene el color de contraste adecuado (blanco o negro) para texto
  static Color getContrastColor(PokemonType type) {
    final color = getColor(type);
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
