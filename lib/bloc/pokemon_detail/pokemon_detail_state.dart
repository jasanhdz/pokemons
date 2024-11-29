import 'package:equatable/equatable.dart';
import 'package:pokemon_api_package/pokemon_api_package.dart';

abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object?> get props => [];
}

class PokemonDetailInitial extends PokemonDetailState {}

class PokemonDetailLoading extends PokemonDetailState {}

class PokemonDetailLoaded extends PokemonDetailState {
  final Pokemon pokemon;

  const PokemonDetailLoaded({required this.pokemon});

  @override
  List<Object?> get props => [pokemon];
}

class PokemonDetailError extends PokemonDetailState {
  final String message;

  const PokemonDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
