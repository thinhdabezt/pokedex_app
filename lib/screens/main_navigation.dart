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
    final theme = Theme.of(context);
    
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: theme.primaryColor, width: 3),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: theme.primaryColor,
          unselectedItemColor: theme.textTheme.bodySmall?.color,
          backgroundColor: theme.cardColor,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'monospace',
            letterSpacing: 0.5,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.catching_pokemon),
              label: "POKÉMON",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "FAVORITES",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flash_on), 
              label: "MOVES",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.backpack), 
              label: "ITEMS",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset),
              label: "GAMES",
            ),
          ],
        ),
      ),
    );
  }
}
