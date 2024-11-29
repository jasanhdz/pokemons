// pokemon_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:pokedex/bloc/pokemon_detail/pokemon_detail_event.dart';
import 'package:pokedex/bloc/pokemon_detail/pokemon_detail_state.dart';
import 'package:pokedex/presentation/widgets/pokemon_list_item.dart';
import 'package:pokemon_api_package/pokemon_api_package.dart';

class PokemonDetailPage extends StatelessWidget {
  final int pokemonId;

  const PokemonDetailPage({Key? key, required this.pokemonId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonDetailBloc(
        pokemonService: PokemonService(),
      )..add(FetchPokemonDetail(pokemonId: pokemonId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalles del Pokémon'),
        ),
        body: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
          builder: (context, state) {
            if (state is PokemonDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PokemonDetailLoaded) {
              final pokemon = state.pokemon;
              return _buildPokemonDetail(pokemon);
            } else if (state is PokemonDetailError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No se encontró el Pokémon'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildPokemonDetail(Pokemon pokemon) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(pokemon.imageUrl),
            SizedBox(height: 16),
            Text(
              '#${pokemon.id} ${pokemon.name.capitalize()}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Añade más detalles aquí
          ],
        ),
      ),
    );
  }
}
