import 'package:flutter/material.dart';
import 'package:pokedex_app/screens/favorites_screen.dart';
import 'package:pokedex_app/screens/home_screen.dart';
import 'package:pokedex_app/screens/item_list_screen.dart';
import 'move_list_screen.dart';
import 'game_list_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    FavoritesScreen(),
    MoveListScreen(),
    ItemListScreen(),
    GameListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: "Pokémon",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: "Moves"),
          BottomNavigationBarItem(icon: Icon(Icons.backpack), label: "Items"),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: "Games",
          ),
        ],
      ),
    );
  }
}
