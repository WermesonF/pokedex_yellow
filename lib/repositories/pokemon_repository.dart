import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pokedex_yellow/models/pokemon.dart';

class PokemonRepository {
  final String api =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  final dio = Dio();

  PokemonRepository();

  Future<List<Pokemon>> getAllPokemons() async {
    try {
      final response = await dio.get(api);
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
