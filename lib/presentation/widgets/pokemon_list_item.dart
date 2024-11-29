import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_api_package/pokemon_api_package.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  PokemonListItem({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('#${pokemon.id}'),
      title: Text(pokemon.name.capitalize()),
      trailing: Image.network(
        pokemon.imageUrl,
        width: 50,
        height: 50,
      ),
      onTap: () {
        context.push('/pokemon/${pokemon.id}');
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
