import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPokemons extends PokemonEvent {
  final bool isRefresh;
  FetchPokemons({this.isRefresh = false});
}

class SearchPokemon extends PokemonEvent {
  final String query;
  SearchPokemon(this.query);

  @override
  List<Object> get props => [query];
}
