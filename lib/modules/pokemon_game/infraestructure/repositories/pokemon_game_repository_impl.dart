import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';

class PokemonGameRepositoryImpl extends PokemonGameRepository {
  final PokemonGameDataSource pokemonGameDataSource;

  PokemonGameRepositoryImpl(this.pokemonGameDataSource);

  @override
  Future<PokemonGame> getPokemonList(String pokemonName) {
    return pokemonGameDataSource.getPokemonList(pokemonName);
  }
}
