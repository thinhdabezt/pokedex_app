import 'package:flutter/material.dart';
import '../services/poke_api_service.dart';

class MoveListProvider extends ChangeNotifier {
  final PokeApiService api;
  final List<String> moves = [];
  final List<String> allMoves = [];
  List<String> displayMoves = [];
  bool isLoading = false;
  int offset = 0;
  final int limit = 20;
  bool hasMore = true;
  String searchQuery = "";

  MoveListProvider(this.api);

  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    notifyListeners();

    final newMoves = await api.fetchMoveList(offset: offset, limit: limit);
    if (newMoves.isEmpty) {
      hasMore = false;
    } else {
      final moveNames = newMoves.map((e) => e["name"]!).toList();
      moves.addAll(moveNames);
      allMoves.addAll(moveNames);
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
      displayMoves = List.from(moves);
    } else {
      displayMoves = allMoves.where((m) {
        return m.toLowerCase().contains(searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  void refresh() {
    moves.clear();
    allMoves.clear();
    displayMoves.clear();
    offset = 0;
    hasMore = true;
    searchQuery = "";
    loadMore();
  }
}
