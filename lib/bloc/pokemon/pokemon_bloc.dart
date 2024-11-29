// pokemon_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:pokemon_api_package/pokemon_api_package.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonService pokemonService;
  int offset = 0;
  final int limit = 20;
  bool isFetching = false;

  PokemonBloc({required this.pokemonService}) : super(PokemonInitial()) {
    on<FetchPokemons>(_onFetchPokemons);
    on<SearchPokemon>(_onSearchPokemon);
  }

  void _onFetchPokemons(FetchPokemons event, Emitter<PokemonState> emit) async {
    if (isFetching) return;
    isFetching = true;

    if (event.isRefresh) {
      offset = 0;
      emit(PokemonLoading());
    }

    try {
      final pokemons =
          await pokemonService.fetchPokemons(limit: limit, offset: offset);
      offset += limit;

      final currentState = state;
      List<Pokemon> allPokemons = [];

      if (currentState is PokemonLoaded && !event.isRefresh) {
        allPokemons = currentState.pokemons + pokemons;
      } else {
        allPokemons = pokemons;
      }

      emit(PokemonLoaded(
        pokemons: allPokemons,
        hasReachedMax: pokemons.length < limit,
      ));
    } catch (e) {
      emit(PokemonError(e.toString()));
    } finally {
      isFetching = false;
    }
  }

  void _onSearchPokemon(SearchPokemon event, Emitter<PokemonState> emit) async {
    emit(PokemonLoading());

    try {
      final pokemon =
          await pokemonService.fetchPokemonByName(event.query.toLowerCase());
      emit(PokemonLoaded(pokemons: [pokemon], hasReachedMax: true));
    } catch (e) {
      if (e is ApiException) {
        emit(PokemonError(e.message));
      } else {
        emit(PokemonError('Error inesperado: $e'));
      }
    }
  }
}
