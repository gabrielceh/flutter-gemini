import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';

class PokemonGameRepositoryImpl extends PokemonGameRepository {
  final PokemonGameDataSource _pokemonGameDataSource;

  PokemonGameRepositoryImpl(this._pokemonGameDataSource);

  @override
  Future<PokemonGame> getPokemonList(String pokemonName) {
    return _pokemonGameDataSource.getPokemonList(pokemonName);
  }
}
