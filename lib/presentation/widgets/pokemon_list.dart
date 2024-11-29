import 'package:flutter/material.dart';
import 'package:pokemon_api_package/pokemon_api_package.dart';
import 'pokemon_list_item.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemons;
  final bool hasReachedMax;
  final ScrollController scrollController;
  final VoidCallback onRefresh;

  const PokemonList({
    Key? key,
    required this.pokemons,
    required this.hasReachedMax,
    required this.scrollController,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        controller: scrollController,
        itemCount: pokemons.length + (hasReachedMax ? 0 : 1),
        itemBuilder: (context, index) {
          if (index < pokemons.length) {
            return PokemonListItem(pokemon: pokemons[index]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
