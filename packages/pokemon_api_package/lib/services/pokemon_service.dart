import 'package:dio/dio.dart';
import '../models/pokemon.dart';
import '../exceptions/api_exception.dart';

class PokemonService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'));

  Future<List<Pokemon>> fetchPokemons({int limit = 20, int offset = 0}) async {
    try {
      final response = await _dio.get('pokemon', queryParameters: {
        'limit': limit,
        'offset': offset,
      });

      List results = response.data['results'];

      List<Future<Pokemon>> futures =
          results.map<Future<Pokemon>>((result) async {
        final detailResponse = await _dio.get(result['url']);
        return Pokemon.fromJson(detailResponse.data);
      }).toList();

      List<Pokemon> pokemons = await Future.wait(futures);

      return pokemons;
    } catch (e) {
      throw ApiException('Error al obtener los Pokémon: $e');
    }
  }

  Future<Pokemon> fetchPokemonByName(String name) async {
    try {
      final response = await _dio.get('pokemon/$name');
      return Pokemon.fromJson(response.data);
    } catch (e) {
      throw ApiException('No se pudo encontrar el Pokémon: $e');
    }
  }

  Future<Pokemon> fetchPokemonById(int id) async {
    try {
      final response = await _dio.get('pokemon/$id');
      return Pokemon.fromJson(response.data);
    } catch (e) {
      throw ApiException('No se pudo encontrar el Pokémon: $e');
    }
  }
}
