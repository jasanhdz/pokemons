import 'package:go_router/go_router.dart';
import 'package:pokedex/presentation/pages/pokemon_list_page.dart';
import 'package:pokedex/presentation/pages/pokemon_detail_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => PokemonListPage(),
      routes: [
        GoRoute(
          path: 'pokemon/:id',
          name: 'pokemonDetail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return PokemonDetailPage(pokemonId: int.parse(id));
          },
        ),
      ],
    ),
  ],
);
