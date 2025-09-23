import 'dart:convert';
import 'package:http/http.dart' as http;
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

    if(resp.statusCode != 200){
      throw Exception("Failed to load Pokémon list :(");
    }

    final map = jsonDecode(resp.body) as Map<String, dynamic>;

    final results = map['results'] as List<dynamic>;

    return results.map((e) => PokemonListItem.fromJson(e)).toList();
  }
}