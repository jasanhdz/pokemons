import 'package:equatable/equatable.dart';
import 'package:pokemon_api_package/pokemon_api_package.dart';

abstract class PokemonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;
  final bool hasReachedMax;

  PokemonLoaded({required this.pokemons, this.hasReachedMax = false});

  PokemonLoaded copyWith({
    List<Pokemon>? pokemons,
    bool? hasReachedMax,
  }) {
    return PokemonLoaded(
      pokemons: pokemons ?? this.pokemons,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [pokemons, hasReachedMax];
}

class PokemonError extends PokemonState {
  final String message;
  PokemonError(this.message);

  @override
  List<Object?> get props => [message];
}
