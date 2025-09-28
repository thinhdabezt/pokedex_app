import 'package:flutter/material.dart';
import '../services/poke_api_service.dart';
import '../models/pokemon_list_item.dart';

class PokemonListProvider extends ChangeNotifier {
  final PokeApiService api;

  List<PokemonListItem> allPokemons = [];
  List<PokemonListItem> displayPokemons = []; 
  final List<PokemonListItem> pokemons = [];
  List<String> types = []; 

  bool isLoading = false;
  String searchQuery = "";
  String? selectedType;
  int offset = 0;
  final int limit = 20;
  bool hasMore = true;

  PokemonListProvider(this.api);

  Future<void> initialize() async {
    isLoading = true;
    notifyListeners();

    try {
      allPokemons = await api.fetchAllPokemonList();
      types = await api.fetchTypes();

      displayPokemons = allPokemons.take(50).toList();
    } catch (e) {
      debugPrint('Error init: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    searchQuery = query.toLowerCase();
    _applyFilters();
  }

  Future<void> setTypeFilter(String? type) async {
    selectedType = type;

    if (type == null) {
      _applyFilters();
    } else {
      isLoading = true;
      notifyListeners();
      try {
        final list = await api.fetchPokemonByType(type);
        displayPokemons = list;
      } catch (e) {
        debugPrint('Error filter type: $e');
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  void _applyFilters() {
    displayPokemons = allPokemons.where((p) {
      return p.name.toLowerCase().contains(searchQuery);
    }).toList();
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    notifyListeners();

    final newPokemons = await api.fetchPokemonList(offset: offset, limit: limit);
    if (newPokemons.isEmpty) {
      hasMore = false;
    } else {
      pokemons.addAll(newPokemons);
      offset += limit;
    }

    isLoading = false;
    notifyListeners();
  }

  void refresh() {
    pokemons.clear();
    offset = 0;
    hasMore = true;
    loadMore();
  }
}
