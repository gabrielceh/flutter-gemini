import 'package:gemini_app/modules/pokemon_game/presentation/providers/is_generating_pokemon_game.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gemini_app/modules/pokemon_game/infraestructure/infraestructure.dart';
import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';

part 'pokemon_game_provider.g.dart';

@riverpod
class PokemonListGame extends _$PokemonListGame {
  final _pokemonGameRepository = PokemonGameRepositoryImpl(
    PokemonGameGeminiDatasource(),
  );

  late final IsGeneratingPokemonGame isGenerating;

  @override
  PokemonGame build() {
    isGenerating = ref.read(isGeneratingPokemonGameProvider.notifier);

    return PokemonGame(
      pokemonSelected: "",
      pokedexNumber: -1,
      imgageUrl: "",
      pokemonList: [],
    );
  }

  Future<void> getPokemon(String pokemonName) async {
    isGenerating.setIsGenerating();
    final pokemonGame = await _pokemonGameRepository.getPokemonList(
      pokemonName,
    );
    print('pokemonGame: ${pokemonGame.pokemonList[0].name}');
    state = pokemonGame;
    isGenerating.setIsNotGenerating();
  }
}
