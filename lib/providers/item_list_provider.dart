import 'package:flutter/material.dart';
import '../services/poke_api_service.dart';

class ItemListProvider extends ChangeNotifier {
  final PokeApiService api;
  final List<String> items = [];
  final List<String> allItems = [];
  List<String> displayItems = [];
  bool isLoading = false;
  int offset = 0;
  final int limit = 20;
  bool hasMore = true;
  String searchQuery = "";

  ItemListProvider(this.api);

  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    notifyListeners();

    final newItems = await api.fetchItemList(offset: offset, limit: limit);
    if (newItems.isEmpty) {
      hasMore = false;
    } else {
      final itemNames = newItems.map((e) => e["name"]!).toList();
      items.addAll(itemNames);
      allItems.addAll(itemNames);
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
      displayItems = List.from(items);
    } else {
      displayItems = allItems.where((i) {
        return i.toLowerCase().contains(searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  void refresh() {
    items.clear();
    allItems.clear();
    displayItems.clear();
    offset = 0;
    hasMore = true;
    searchQuery = "";
    loadMore();
  }
}
