import 'package:gemini_app/config/gemini/gemini_impl.dart';
import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';

class PokemonGameGeminiDatasource extends PokemonGameDataSource {
  final _gemini = GeminiImpl();

  @override
  Future<PokemonGame> getPokemonList(String pokemonName) {
    return _gemini.getPokemonGame(pokemonName);
  }
}
