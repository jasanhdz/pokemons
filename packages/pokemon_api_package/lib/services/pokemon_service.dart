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
    } on DioException catch (e) {
      throw ApiException(_handleDioError(e));
    } catch (e) {
      throw ApiException('Error inesperado: $e');
    }
  }

  Future<Pokemon> fetchPokemonByName(String name) async {
    try {
      final response = await _dio.get('pokemon/$name');
      return Pokemon.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(_handleDioError(e));
    } catch (e) {
      throw ApiException('Error inesperado: $e');
    }
  }

  Future<Pokemon> fetchPokemonById(int id) async {
    try {
      final response = await _dio.get('pokemon/$id');
      return Pokemon.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(_handleDioError(e));
    } catch (e) {
      throw ApiException('Error inesperado: $e');
    }
  }

  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return 'Tiempo de conexión agotado. Por favor, revisa tu conexión a Internet.';
    } else if (e.type == DioExceptionType.badResponse) {
      return 'Error en la respuesta del servidor (${e.response?.statusCode}): ${e.response?.statusMessage}';
    } else if (e.type == DioExceptionType.unknown) {
      return 'Error desconocido: ${e.message}';
    } else {
      return 'Error al realizar la solicitud: ${e.message}';
    }
  }
}
