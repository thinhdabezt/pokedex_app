import 'package:flutter/material.dart';
import 'package:pokedex_app/providers/pokemon_list_providers.dart';
import 'package:provider/provider.dart';
import '../widgets/pokemon_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // khởi tạo khi mở app
    Future.microtask(() =>
        Provider.of<PokemonListProviders>(context, listen: false).initialize());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonListProviders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Search Pokémon",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
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
                      const DropdownMenuItem(
                          value: null, child: Text("All")),
                      ...provider.types.map((t) =>
                          DropdownMenuItem(value: t, child: Text(t.toUpperCase())))
                    ],
                    onChanged: provider.setTypeFilter,
                  ),
                ),

                const SizedBox(height: 8),

                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: provider.displayPokemons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
