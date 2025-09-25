import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/models/pokemon_detail.dart';
import '../models/pokemon_list_item.dart';

class PokeApiService {
  static const _base = 'https://pokeapi.co/api/v2';

  final http.Client client;

  PokeApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<PokemonListItem>> fetchAllPokemonList() async {
    final url = Uri.parse('$_base/pokemon?limit=100000&offset=0');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;

      return results.map((item) {
        final id = _extractIdFromUrl(item['url']);
        return PokemonListItem(
          name: item['name'],
          url: item['url'],
          imageUrl:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
          id: id,
          types: [],
        );
      }).toList();
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }

  Future<List<PokemonListItem>> fetchPokemonList(
      {int limit = 1500, int offset = 0}) async {
    final url = Uri.parse('$_base/pokemon?limit=$limit&offset=$offset');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;

      return results.map((item) {
        final id = _extractIdFromUrl(item['url']);
        return PokemonListItem(
          name: item['name'],
          url: item['url'],
          imageUrl:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
          id: id,
          types: [],
        );
      }).toList();
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  Future<PokemonDetail> fetchPokemonDetail(int id) async {
    final box = Hive.box<Map>('pokemon_details');

    if(box.containsKey(id)){
      final cached = Map<String, dynamic>.from(box.get(id)!);
      return PokemonDetail.fromJson(cached);
    }

    final uri = Uri.parse('$_base/pokemon/$id');
    final resp = await client.get(uri);

    if (resp.statusCode != 200) {
      throw Exception('Failed to load Pokémon detail');
    }

    final map = jsonDecode(resp.body) as Map<String, dynamic>;

    await box.put(id, map);

    return PokemonDetail.fromJson(map);
  }

  Future<List<PokemonListItem>> fetchPokemonByType(String type) async {
    final url = Uri.parse('$_base/type/$type');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['pokemon'] as List;

      return results.map((item) {
        final poke = item['pokemon'];
        final id = _extractIdFromUrl(poke['url']);
        return PokemonListItem(
          name: poke['name'],
          url: poke['url'],
          imageUrl:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
          id: id,
          types: [type],
        );
      }).toList();
    } else {
      throw Exception('Failed to load Pokémon by type');
    }
  }

  Future<List<String>> fetchTypes() async {
    final url = Uri.parse('$_base/type');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      return results.map<String>((item) => item['name'] as String).toList();
    } else {
      throw Exception('Failed to load types');
    }
  }

  int _extractIdFromUrl(String url) {
    final parts = url.split('/');
    return int.parse(parts[parts.length - 2]);
  }
}
