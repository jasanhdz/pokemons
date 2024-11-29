import 'package:flutter/material.dart';

class PokemonSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const PokemonSearchBar({
    Key? key,
    required this.controller,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: false,
      enableSuggestions: false,
      decoration: const InputDecoration(
        hintText: 'Buscar Pokémon por nombre',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onSubmitted: onSubmitted,
    );
  }
}
