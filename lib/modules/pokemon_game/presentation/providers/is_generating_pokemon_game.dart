import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_generating_pokemon_game.g.dart';

@riverpod
class IsGeneratingPokemonGame extends _$IsGeneratingPokemonGame {
  @override
  bool build() => false;

  void setIsGenerating() {
    state = true;
  }

  void setIsNotGenerating() {
    state = false;
  }
}
