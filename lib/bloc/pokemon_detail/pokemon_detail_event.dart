import 'package:equatable/equatable.dart';

abstract class PokemonDetailEvent extends Equatable {
  const PokemonDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonDetail extends PokemonDetailEvent {
  final int pokemonId;

  const FetchPokemonDetail({required this.pokemonId});

  @override
  List<Object> get props => [pokemonId];
}
