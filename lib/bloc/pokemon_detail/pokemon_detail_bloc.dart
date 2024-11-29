// pokemon_detail_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api_package/pokemon_api_package.dart';
import 'pokemon_detail_event.dart';
import 'pokemon_detail_state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final PokemonService pokemonService;

  PokemonDetailBloc({required this.pokemonService})
      : super(PokemonDetailInitial()) {
    on<FetchPokemonDetail>(_onFetchPokemonDetail);
  }

  void _onFetchPokemonDetail(
      FetchPokemonDetail event, Emitter<PokemonDetailState> emit) async {
    emit(PokemonDetailLoading());
    try {
      final pokemon = await pokemonService.fetchPokemonById(event.pokemonId);
      emit(PokemonDetailLoaded(pokemon: pokemon));
    } catch (e) {
      emit(PokemonDetailError(message: e.toString()));
    }
  }
}
