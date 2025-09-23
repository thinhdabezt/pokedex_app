import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_list_item.dart';
import 'package:pokedex_app/services/poke_api_service.dart';

class PokemonListProviders extends ChangeNotifier {
  final PokeApiService api;

  List<PokemonListItem> mons = [];
  List<PokemonListItem> filteredMons = [];

  bool isLoading = false;
  bool hasNext = true;
  int offset = 0;
  final int limit = 20;

  String seacrhQuery = "";
  String? selectedType;

  PokemonListProviders(this.api);

  Future<void> fetchNext() async {
    if(isLoading || !hasNext){
      return;
    }

    isLoading = true;
    notifyListeners();

    try{
      final list = await api.fetchPokemonList(limit: limit, offset: offset);

      mons.addAll(list);

      offset += limit;

      if(list.length < limit){
        hasNext = false;
      } 
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    mons.clear();
    offset = 0;
    hasNext = true;
    await fetchNext();
  }
}