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

    final screen = [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Pokémon',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: provider.setSearchQuery,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Filter by Type"),
              value: provider.selectedType,
              items: [
                const DropdownMenuItem(value: null, child: Text("All")),
                ...provider.types.map(
                  (t) =>
                      DropdownMenuItem(value: t, child: Text(t.toUpperCase())),
                ),
              ],
              onChanged: provider.setTypeFilter,
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: provider.isLoading && provider.pokemons.isEmpty
                ? ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, __) => buildShimmerItem(),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: provider.displayPokemons.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
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
        title: const Text('Pokedex'),
      ),
      body: screen[_selectedIndex],
    );
  }
}
