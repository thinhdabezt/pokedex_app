import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesProvider extends ChangeNotifier {
  final Box<int> _box = Hive.box<int>('favorites');

  List<int> get favoriteIds => _box.values.toList();

  bool isFavorite(int id) => _box.values.contains(id);

  void toggleFavorite(int id) {
    if(isFavorite(id)){
      final key = _box.keys.firstWhere((k) => _box.get(k) == id);
      _box.delete(key);
    } else {
      _box.add(id);
    }

    notifyListeners();
  }
}