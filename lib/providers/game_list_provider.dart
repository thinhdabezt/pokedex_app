import 'package:flutter/material.dart';
import '../services/poke_api_service.dart';

class GameListProvider extends ChangeNotifier {
  final PokeApiService api;
  final List<String> games = [];
  final List<String> allGames = [];
  List<String> displayGames = [];
  bool isLoading = false;
  int offset = 0;
  final int limit = 20;
  bool hasMore = true;
  String searchQuery = "";

  GameListProvider(this.api);

  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    notifyListeners();

    final newGames = await api.fetchGameList(offset: offset, limit: limit);
    if (newGames.isEmpty) {
      hasMore = false;
    } else {
      final gameNames = newGames.map((e) => e["name"]!).toList();
      games.addAll(gameNames);
      allGames.addAll(gameNames);
      offset += limit;
    }

    _applyFilters();
    isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    if (searchQuery.isEmpty) {
      displayGames = List.from(games);
    } else {
      displayGames = allGames.where((g) {
        return g.toLowerCase().contains(searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  void refresh() {
    games.clear();
    allGames.clear();
    displayGames.clear();
    offset = 0;
    hasMore = true;
    searchQuery = "";
    loadMore();
  }
}
