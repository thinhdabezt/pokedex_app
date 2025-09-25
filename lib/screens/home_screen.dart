import 'package:flutter/material.dart';
import 'package:pokedex_app/providers/pokemon_list_providers.dart';
import 'package:provider/provider.dart';
import '../widgets/pokemon_card.dart';
import '../services/poke_api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> types = [];

  @override
  void initState() {
    super.initState();
    _loadTypes();
  }

  Future<void> _loadTypes() async {
    final api = PokeApiService();
    final list = await api.fetchTypes();
    setState(() {
      types = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonListProviders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: Column(
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
                const DropdownMenuItem(value: null, child: Text("All")),
                ...types.map((t) =>
                    DropdownMenuItem(value: t, child: Text(t.toUpperCase()))),
              ],
              onChanged: provider.setTypeFilter,
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: RefreshIndicator(
              onRefresh: provider.refresh,
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (!provider.isLoading &&
                      scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200) {
                    provider.fetchNext();
                  }
                  return false;
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: provider.filteredMons.length +
                      (provider.hasNext ? 1 : 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    if (index >= provider.filteredMons.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final p = provider.filteredMons[index];
                    return PokemonCard(pokemon: p);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
