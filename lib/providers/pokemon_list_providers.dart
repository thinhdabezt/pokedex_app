import 'package:flutter/material.dart';
import '../services/poke_api_service.dart';
import '../models/pokemon_list_item.dart';

class PokemonListProviders extends ChangeNotifier {
  final PokeApiService api;

  List<PokemonListItem> pokemons = [];
  List<PokemonListItem> filteredMons = []; // danh sách sau khi search/filter

  bool isLoading = false;
  bool hasNext = true;
  int offset = 0;
  final int limit = 1500;

  String searchQuery = "";
  String? selectedType;

  PokemonListProviders(this.api);

  Future<void> fetchNext() async {
    if (isLoading || !hasNext) return;

    isLoading = true;
    notifyListeners();

    try {
      final list = await api.fetchPokemonList(limit: limit, offset: offset);

      pokemons.addAll(list);
      offset += limit;

      if (list.length < limit) hasNext = false;

      // Mỗi khi load thêm → cập nhật filter
      applyFilters();
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    pokemons.clear();
    filteredMons.clear();
    offset = 0;
    hasNext = true;
    await fetchNext();
  }

  // Set query tìm kiếm
  void setSearchQuery(String query) {
    searchQuery = query.toLowerCase();
    applyFilters();
  }

  // Set bộ lọc theo type
  void setTypeFilter(String? type) {
    selectedType = type;
    applyFilters();
  }

  // Áp dụng tìm kiếm + lọc
  void applyFilters() {
    filteredMons = pokemons.where((p) {
      final matchSearch =
          searchQuery.isEmpty || p.name.toLowerCase().contains(searchQuery);
      final matchType = selectedType == null || p.types.contains(selectedType);
      return matchSearch && matchType;
    }).toList();

    notifyListeners();
  }
}
