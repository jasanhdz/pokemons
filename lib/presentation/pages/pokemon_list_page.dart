import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon/pokemon_state.dart';
import 'package:pokedex/presentation/widgets/search_bar.dart';
import 'package:pokedex/presentation/widgets/pokemon_list.dart';

class PokemonListPage extends StatefulWidget {
  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late PokemonBloc _pokemonBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    _pokemonBloc.add(FetchPokemons());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      _pokemonBloc.add(SearchPokemon(query));
    } else {
      _pokemonBloc.add(FetchPokemons(isRefresh: true));
    }
  }

  void _onScroll() {
    if (_isBottom && !_pokemonBloc.isFetching) {
      _pokemonBloc.add(FetchPokemons());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: PokemonSearchBar(
              controller: _searchController,
              onSubmitted: _onSearchSubmitted,
            ),
          ),
        ),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading && !(state is PokemonLoaded)) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PokemonLoaded) {
            return PokemonList(
              pokemons: state.pokemons,
              hasReachedMax: state.hasReachedMax,
              scrollController: _scrollController,
              onRefresh: () {
                _pokemonBloc.add(FetchPokemons(isRefresh: true));
              },
            );
          } else if (state is PokemonError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No hay datos'));
          }
        },
      ),
    );
  }
}
