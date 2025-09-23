import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/models/pokemon_detail.dart';
import '../models/pokemon_list_item.dart';

class PokeApiService {
  static const _base = 'https://pokeapi.co/api/v2';

  final http.Client client;

  PokeApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<PokemonListItem>> fetchPokemonList({
    int limit = 20,
    int offset = 0,
  }) async {
    final uri = Uri.parse('$_base/pokemon?limit=$limit&offset=$offset');

    final resp = await client.get(uri);

    if (resp.statusCode != 200) {
      throw Exception("Failed to load Pokémon list :(");
    }

    final map = jsonDecode(resp.body) as Map<String, dynamic>;

    final results = map['results'] as List<dynamic>;

    return results.map((e) => PokemonListItem.fromJson(e)).toList();
  }

  Future<PokemonDetail> fetchPokemonDetail(int id) async {
    final uri = Uri.parse('$_base/pokemon/$id');
    final resp = await client.get(uri);

    if (resp.statusCode != 200) {
      throw Exception('Failed to load Pokémon detail');
    } 

    final map = jsonDecode(resp.body) as Map<String, dynamic>;
    return PokemonDetail.fromJson(map);
  }
}
