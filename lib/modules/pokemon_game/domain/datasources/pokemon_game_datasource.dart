import 'package:gemini_app/modules/pokemon_game/domain/entities/pokemon_game.dart';

abstract class PokemonGameDataSource {
  Future<PokemonGame> getPokemonList();
}
