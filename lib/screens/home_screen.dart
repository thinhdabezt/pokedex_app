import 'package:flutter/material.dart';
import 'package:pokedex_app/providers/pokemon_list_provider.dart';
import 'package:pokedex_app/screens/favorites_screen.dart';
import 'package:pokedex_app/widgets/shimmer.dart';
import 'package:provider/provider.dart';
import '../widgets/pokemon_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<PokemonListProvider>(context, listen: false).initialize(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PokemonListProvider>(context, listen: false);
      provider.loadMore();

      controller.addListener(() {
        if (controller.position.pixels >=
            controller.position.maxScrollExtent - 200) {
          provider.loadMore();
        }
      });
    });

    // final provider = Provider.of<PokemonListProvider>(context, listen: false);
    // provider.loadMore();

    // controller.addListener(() {
    //   if (controller.position.pixels >=
    //       controller.position.maxScrollExtent - 200) {
    //     provider.loadMore();
    //   }
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonListProvider>(context);
    final theme = Theme.of(context);

    final screen = [
      Column(
        children: [
          // Pixel-styled search bar
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: theme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'SEARCH POKÉMON...',
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: theme.primaryColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, 
                  vertical: 12,
                ),
              ),
              style: theme.textTheme.bodyLarge,
              onChanged: provider.setSearchQuery,
            ),
          ),

          // Pixel-styled dropdown
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: theme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(8),
              color: theme.cardColor,
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                "FILTER BY TYPE",
                style: theme.textTheme.bodyLarge?.copyWith(
                  letterSpacing: 0.5,
                ),
              ),
              value: provider.selectedType,
              underline: Container(),
              icon: Icon(
                Icons.arrow_drop_down,
                color: theme.primaryColor,
              ),
              dropdownColor: theme.cardColor,
              style: theme.textTheme.bodyLarge,
              items: [
                DropdownMenuItem(
                  value: null, 
                  child: Text(
                    "ALL TYPES",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                ...provider.types.map(
                  (t) => DropdownMenuItem(
                    value: t, 
                    child: Text(
                      t.toUpperCase(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
              onChanged: provider.setTypeFilter,
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: provider.isLoading && provider.pokemons.isEmpty
                ? ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, __) => buildShimmerItem(),
                  )
                : GridView.builder(
                    controller: controller,
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.displayPokemons.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final p = provider.displayPokemons[index];
                      return PokemonCard(pokemon: p);
                    },
                  ),
          ),
        ],
      ),
      const FavoritesScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('POKÉDEX'),
      ),
      body: screen[_selectedIndex],
    );
  }
}
