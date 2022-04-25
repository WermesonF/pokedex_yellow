import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pokedex_yellow/models/pokemon.dart';

class PokemonRepository {
  final String _api =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  final _dio = Dio();

  PokemonRepository();

  Future<List<Pokemon>> getAllPokemons() async {
    try {
      final response = await _dio.get(_api);
      final json = jsonDecode(response.data) as Map<String, dynamic>;
      final list = json['pokemon'] as List<dynamic>;

      if(list.isNotEmpty) {
        return list.map((e) => Pokemon.fromMap(e)).toList();
      } else {
        return [];
      }
    } on DioError catch (e) {
      throw Exception("API ERRO:" + e.message);
    }
  }
}
