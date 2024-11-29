import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/config/router/app_router.dart';
import 'package:pokemon_api_package/pokemon_api_package.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PokemonService pokemonService = PokemonService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PokemonBloc(pokemonService: pokemonService),
        ),
      ],
      child: MaterialApp.router(
        title: 'Pokédex',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
