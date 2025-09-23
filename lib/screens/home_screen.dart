import 'package:flutter/material.dart';
import 'package:pokedex_app/providers/pokemon_list_providers.dart';
import 'package:pokedex_app/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonListProviders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Pokedex")),
      body: RefreshIndicator(
        onRefresh: provider.refresh,
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (!provider.isLoading &&
                provider.hasNext &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 200) {
              provider.fetchNext();
            }
            return false;
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: provider.mons.length + (provider.isLoading ? 1 : 0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              if (index < provider.mons.length) {
                final p = provider.mons[index];
                return PokemonCard(pokemon: p);
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
