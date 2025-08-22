import 'package:gemini_app/modules/pokemon_game/domain/domain.dart';
import 'package:gemini_app/modules/pokemon_game/infraestructure/models/pokemon_game_response.dart';

class PokemonGameMapper {
  static PokemonGame pokemonGameToEntity(
    PokemonGameResponse pokemonGameResponse,
  ) {
    String imageUrl(int pokedexNumber) {
      return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokedexNumber.png';
    }

    return PokemonGame(
      pokemonSelected: pokemonGameResponse.pokemonSelected,
      pokedexNumber: pokemonGameResponse.pokedexNumber,
      imgageUrl: imageUrl(pokemonGameResponse.pokedexNumber),

      pokemonList: pokemonGameResponse.pokemonList
          .map(
            (pokemon) => PokemonList(
              name: pokemon.name,
              attack: PokemonAttack(
                en: pokemon.attack.en,
                es: pokemon.attack.es,
              ),
              pokedexNumber: pokemon.pokedexNumber,
              imgageUrl: imageUrl(pokemon.pokedexNumber),
              types: pokemon.types
                  .map((type) => PokemonType.fromString(type)!)
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
